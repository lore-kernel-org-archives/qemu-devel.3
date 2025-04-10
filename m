Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747A9C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 12:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2qtx-0002IA-1P; Thu, 10 Apr 2025 08:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2qtv-0002EJ-AT
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2qtt-0008Bc-Ld
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744287655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=aEnVz93x0Gb7dSkMzN+El6WGtFG7V6tonqe2nsdDSvBDnzOm+IYeqxxVgYCRb8/Rp/GLG9
 M9TGuW1FMzcgQV9qM/qKGF76+yur3QeRtykTC/xRcqq6xzmyR/mdFSyhRXF3jCcl7TkCEa
 Isl5OGTxoN3Ql09qMNZ6PUZ8cvTcRI0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-hbX8X5xaP1iFbSscwtrnlA-1; Thu, 10 Apr 2025 08:20:53 -0400
X-MC-Unique: hbX8X5xaP1iFbSscwtrnlA-1
X-Mimecast-MFC-AGG-ID: hbX8X5xaP1iFbSscwtrnlA_1744287653
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5e6c14c0a95so637694a12.0
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 05:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744287652; x=1744892452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=l2fmQGAz7QTkyJsGshEjO5eyY09JQswuw9Z0KLYl2Ih/mogpxUYSHoZ1mjmHUxcX0j
 DLoNbU8ZCG4UHduPl/igo6/GxvEoooKYctTG5nvGrhO7zcAy+E2UAseRm6ddusjXpxuM
 dExYcBuPO6pzXbKzUWiE6lgPTh9nmQdj0HApOqAwNGhY2NsEXduICenIdmGi3fjZRDZE
 qxy24VwLXZWuhVJZQ3ws7ZDnyPtXcMSI6/HuqM37jufKDcJz1a1PsRWqVT8/AidXGxJI
 rRaL2JKuE7IWNs0gX8TU9cn6bKjH0t/I8sO5yyX8nSH3wMYSSPIiqiAid4ZB7QZ1i7af
 /pSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWE9pd4NPpeEsT0R1FP/BcCDB1T/F7TcbayvNC2LrDjGTvjPkqD9oFBA50w/9R+um/YTuugomsScQUz@nongnu.org
X-Gm-Message-State: AOJu0YxtjcDklgmFwTs3iFRILcOnrE05zVfyibAay3hZ55UlBFhWGxlJ
 ktmVhMRCRim6VdDo3xPO5pXkxJQIzCj+wzu6phfNx1U91GSdZTWbYZ21Wch8r2A2/kC+2eEq3iT
 nsKBWREeydU3EIoMGc2jeBsP0DhtF7KeqKCYbKAV89Gjt5r+6pb4Bc0arA8AO
X-Gm-Gg: ASbGncsM82LYx/MEZWUj4ZuALSx062pOYwh1MGx1yXAbe+e3z0Gk6TSPM2vjVpA6+eG
 qvIY+q2AFNMC0Ha5+ZecFDwBGdX9y52nOI5xcfOdwDvltZjTDAfi6LU3xyLt+MyrK11JtFLgo4D
 yA5oA/mmbHLZSkGYGREeKWIxIUkHRfxYYfE2N0NRrZAakPjSbmyy4RCb/YI/6LIGype5B6MW/n+
 c0nHE7/hkuyBTCQUFot1HMultiBMGNQxeJRndxvP/qCNas2ctqMHI+Myms+iQSHIEWxI3Xrfqf/
 dmZK/3deqj0vZonPXw==
X-Received: by 2002:a05:6402:234f:b0:5e8:c0a7:4244 with SMTP id
 4fb4d7f45d1cf-5f32924b117mr1768358a12.9.1744287651906; 
 Thu, 10 Apr 2025 05:20:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoJGRNuFrF0i2e+SHnYE6veyKGWoR7O2H0aMuvN1f1w9xRpZD4fslY1VZE8wdbSyjBTmKPjA==
X-Received: by 2002:a05:6402:234f:b0:5e8:c0a7:4244 with SMTP id
 4fb4d7f45d1cf-5f32924b117mr1768342a12.9.1744287651597; 
 Thu, 10 Apr 2025 05:20:51 -0700 (PDT)
Received: from [192.168.122.1] ([176.206.103.255])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f2fbc2e3f8sm2278647a12.48.2025.04.10.05.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 05:20:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] i386/cpu: Consolidate the helper to get Host's vendor
Date: Thu, 10 Apr 2025 14:20:46 +0200
Message-ID: <20250410122046.534970-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410075619.145792-1-zhao1.liu@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


