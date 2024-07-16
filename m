Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D9EC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 08:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTdrb-0006j9-JQ; Tue, 16 Jul 2024 04:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTdrY-0006Yc-RA
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:48:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTdrX-0006LQ-8V
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721119722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=U6AUfVl/j3kl3mGOjZCwr95vPZc6dktii65Jq3Not7KHeY79quNsxddrsyJHCEH/8LI1kL
 v3Hyk/cpxWtiDMRNP710IfpLtwHM6fPbNU3Ee1dJHefcpWl8+la86QUUFgXZaDpAZeUgOG
 n94IZxbRdRzTM3PQsH91ZMCwNan2tHA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-_DjN6AGjPDaen7b_g2ylzQ-1; Tue, 16 Jul 2024 04:48:40 -0400
X-MC-Unique: _DjN6AGjPDaen7b_g2ylzQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4279418eb2bso34696925e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 01:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721119719; x=1721724519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=VcORN3Ampn5/15JUuHI4coAjdHxhjNGIua9BGggySWeM45D4CbatlzTqUy48LDJHE1
 Ers+8lnJxRc0/6D8U5dAY1WhfpBG1M5KCE8u12edZbzUuFsnZc/029YjzWyq+O5whYkf
 em3g4MbPW4/CKk4Uk+6VVdc1lKkssTaR6X6kfxaWvptQiHOMh0exBfgMAEnYzEUu1V7W
 R/4oU/qce1TnD4o02qaewav3mFim3anb5iQqvEvq08Ff8IwNs65EaVNzzO4J+EC5Jx7T
 qtmK969gO6dAz7v6fUXf+eMRt1NcmvkWxNYv/GlCDxC/kfRslTVfbhOgafmAqBd854Uf
 WFxA==
X-Gm-Message-State: AOJu0YzAc4o9/JIvd+iCne+bEz0dWis2RTrq5MhMOnJGb3wfBeM6c1A4
 IBcBZYfp8hS/wzyVh/HYiOH6Lubyvd62QoDWopO4vYTlVkUe+QItNNKayJO8kG40Gk2TCMNB99s
 eZb/ZlEeSw40ktcI6YsAAYgCHpD0mn4wBMzJbvBEP/TvAFNGDDM3D214/dlPO
X-Received: by 2002:a05:600c:3b8c:b0:426:5d0d:a2c9 with SMTP id
 5b1f17b1804b1-427ba677352mr9112455e9.10.1721119719387; 
 Tue, 16 Jul 2024 01:48:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmhWChjFmAN4R28hdSi0wv74g0Sl0pLWJz/BCm1xfQgB91MW7CpaNuLkdK1Ml175CmeXmZTw==
X-Received: by 2002:a05:600c:3b8c:b0:426:5d0d:a2c9 with SMTP id
 5b1f17b1804b1-427ba677352mr9112325e9.10.1721119719014; 
 Tue, 16 Jul 2024 01:48:39 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef3256sm115834005e9.39.2024.07.16.01.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 01:48:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,
	peter.maydell@linaro.org,
	alex.bennee@linaro.org
Subject: Re: [PATCH] disas: Fix build against Capstone v6
Date: Tue, 16 Jul 2024 10:48:36 +0200
Message-ID: <20240716084836.185488-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715213943.1210355-1-gustavo.romero@linaro.org>
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


