Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B3DC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 11:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOxui-0006a5-Jx; Wed, 03 Jul 2024 07:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOxuS-0006Rz-0C
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOxuO-00014w-RP
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 07:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720005139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Tu+AwHgqlx8omxivKOmkjnUP5QKkdpTQaeMZERT/80VNtwCLy9ka+TI1wnjuHJ7LpuVGJ8
 tCVZpc8M4qkXVYkOptpyUK/D2KreNC+CxnbOsd6+tsKamDazNw2t0gu0tYu3qBb0X20pMW
 XEvY/Xn6g7v2Xu3N23mWa1CDZdydJeg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-fTZ_pO3PNWG3_6lfQEfoIg-1; Wed, 03 Jul 2024 07:12:13 -0400
X-MC-Unique: fTZ_pO3PNWG3_6lfQEfoIg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4257a75193aso26935025e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 04:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720005132; x=1720609932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=nVFfxpefJjbb48rHbYVqkzTpIX2TIzSPlU4d450Kc3283x965VJPCuvK821inq7PsX
 Vjofl5E+1l8y0JOtZv6ErQLo+KYg60cU067a/GIYarW56Ggf5C+KfL8JoAdSgRFO/MYo
 jDi7cPPO0OyHb36hGiT94B8oCyDWFueKEpi3NWdBy14BRYVAqziLWa8neFc65BC2gnXS
 ZXyRIom5kj/SkPcPAIWWF7K86BSgAa99onhPwPP9LTRhW1hVZwmTMEekFojYMiXuefnP
 yJgvRp/jnweWYHXmr6PEwcfPHCuIIwPJewX6dUnth0YZXypR08Uwfw9lKFl0+JkOLjxb
 imNw==
X-Gm-Message-State: AOJu0YwdhtLtQb2wHpoNePx4HFMHD40+kQwAluQaZ8aO/6ulbLLaxH38
 E7Y8f8aW3oBN84bkRK7nIpvmGiMyyN8Hj94gd5xqoL9BjG8FbUBqhqjViELPdiBR7C50kytp8RD
 oQnlAi4JelAkDmcG8TGNGMXokXEklcsmGFIRXDwk8NL6pJlqHoyd+
X-Received: by 2002:a05:600c:4f13:b0:424:7dae:7d79 with SMTP id
 5b1f17b1804b1-4257a009c65mr70333935e9.7.1720005132337; 
 Wed, 03 Jul 2024 04:12:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYuNKXPpHsiKeyCoyNMov0Et8frzFtCUFL181lF7jmMuZXDrFGeQYemFsY2AY9kelGXcL7aQ==
X-Received: by 2002:a05:600c:4f13:b0:424:7dae:7d79 with SMTP id
 5b1f17b1804b1-4257a009c65mr70333805e9.7.1720005132021; 
 Wed, 03 Jul 2024 04:12:12 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0621fesm232717835e9.24.2024.07.03.04.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 04:12:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 michael.roth@amd.com
Subject: Re: [PATCH 0/2] i386/sev: Two trivial improvements to
 sev_get_capabilities()
Date: Wed,  3 Jul 2024 13:12:09 +0200
Message-ID: <20240703111209.1650300-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719218926.git.mprivozn@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


