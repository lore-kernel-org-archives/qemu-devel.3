Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC1BC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 07:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF7g8-0001rx-Sx; Thu, 06 Jun 2024 03:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF7g5-0001rL-5s
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 03:36:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF7fv-00080H-N9
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 03:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717659401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=dFHCeC2o2i5GUKF0FZLGyu2wFWo0LV2absS0je8iATwnTucgrhenoFOn4QW1g92Zn/npMu
 spHsrhXpqjckKkT3hsgXiWCsE6QlT7I01usFFvT4W6tMtrw1GLpaAzger/88X5hbkrSfi0
 hdY4hBniwZu9HgIRt6waiTBAcXPI5L4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-cIW6I-clPEOFo2EzeMgO3w-1; Thu, 06 Jun 2024 03:36:40 -0400
X-MC-Unique: cIW6I-clPEOFo2EzeMgO3w-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6c72164f46so32338066b.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 00:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717659399; x=1718264199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=qg/27HzxNsjB06Gb5yvcGouRKOutHFnhzijKuGYHc4zAkpiBnQkdx2J/FWITodQOUV
 /LO8a0WQf+cmrgyYPUeThP/XH62Kadt3dzSu83IbPh04mrD4tDGOPEnTYVNO48KyfiSd
 k9iupYPsYH2er/HG1u4FJDYQACgM78XZkbvVpWkvV++m2Bf340tWjGrzElesO9h9ZNKq
 Qx4FwwrYwKb0h52Scj3S5vHktUJ08Jh8IJFxs2Aiz4u8QQD024C1SbpMzF6Ih4FE9qHW
 Psb8M5XKnXhV+1wRJe82fd/qLENLEyjVKw0W5bAdPPa/zuZzgQqm1ijDX9O//uZ2wWhf
 SG8A==
X-Gm-Message-State: AOJu0YxZ3kb2wzittDqPxef0S29fIH0dXZkisj30IF5QRQ/mWIgBJtog
 bjVvfYPGSwlcwJ/EOkhHffXcV0VzqmXGq+5pGctpPvfoNkxLyzDR3iRfkgt8sTckJEZgiPsYuNL
 sKciQe43nFl061MOFg2Z3oUc8Hd1+KJlCtycQQd7inLkXBCjiJcZRk1UqQC1t
X-Received: by 2002:a17:907:cb06:b0:a6c:70b9:1608 with SMTP id
 a640c23a62f3a-a6c70b922a8mr153327366b.16.1717659398986; 
 Thu, 06 Jun 2024 00:36:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzBetlN9OFyJG6dDF3LAkIGf6AVSR0mbFChI6DUSbL/uAJ7bjkRKFKg3EUTvJ8lvqoiul5WA==
X-Received: by 2002:a17:907:cb06:b0:a6c:70b9:1608 with SMTP id
 a640c23a62f3a-a6c70b922a8mr153326066b.16.1717659398578; 
 Thu, 06 Jun 2024 00:36:38 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805d0af8sm56202966b.87.2024.06.06.00.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 00:36:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 0/5] backends/hostmem: Report more errors on failures
Date: Thu,  6 Jun 2024 09:36:35 +0200
Message-ID: <20240606073635.2454348-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1717584048.git.mprivozn@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Queued, thanks.

Paolo


