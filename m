Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E68CA0EF8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 20:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uopjA-0006cm-9x; Wed, 20 Aug 2025 16:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uopj8-0006cV-GM
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 16:48:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uopj5-0000yx-Tn
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 16:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755722885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=GW20dLEGR68H+oApIwT1Y+Q6vkZKpumVQvcyFCuE82YSVipBG6WIaWO2CvQKcXsIYeUkMm
 0rtEfSmOXS3y7H1S5iRaD0ZydCEmppZclZ/tAvf+sOzN4h4YkR7bEi0Nh2J6lY3oYOQUqt
 tXvkceT7as1T5UGNu7D++c6hlBbtUUg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-0wX9rhrnMcGYXBXEMcAS0A-1; Wed, 20 Aug 2025 16:48:03 -0400
X-MC-Unique: 0wX9rhrnMcGYXBXEMcAS0A-1
X-Mimecast-MFC-AGG-ID: 0wX9rhrnMcGYXBXEMcAS0A_1755722882
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b467f5173so1525405e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 13:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755722882; x=1756327682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=WYshrg9IXHrGbEXCXg2arfzjvxN4jG51IKQcJf2VS+LY8INEQdlui/MXbzVky+v/Es
 Mg6azfiP9k6W9KLjdNFsldWY1U6lGV9PGdHV+me1Qii2dmrNtR2RLSFYM4d38DTN3N95
 VhBdcPvimEnowLSuOpdosdiUz5Uz/6A/Nm6fXI69tl+Xbetg4Lut3tBJy1Q8OTcYOvSk
 GnYCq22SIyIQ+e9TZ9lo62324z9607jRBoH0MEHvFbapj0f6ULxz1EBHVgXbU6oiqgfh
 r1S4kfLLoEwy5PgtS4cvEUeCsSxFBBMgUdFPyLM52Syz1XxC40mmXwwUiw/0mGpq85WW
 zFqw==
X-Gm-Message-State: AOJu0YzbmgddyxmeHqFSvYhPZ5EJp1Cj/skCA5uKA16XgctP8JZiCcrc
 AOePtlpWGRJuD0s1sa5gKrVOUrU+sZ73EYnNQTykL4lBWv5EIRTG1/TxAZILrPHBDiP3CrU+Mhc
 nZfvBdLsxiBxyOp+TzUqoxqs1WoqfgoZ6ye4/o8ZqIc1vAQ/9MT9GwVd0
X-Gm-Gg: ASbGnct+L3+JCjyoO5gRCGXRRsd2JG1pFMFg+5hiXhXkjPmpe9CbSLutUwYCAq9WeK4
 WthZOquVrgSRYjOICNqVWVbtDLD5hx050p/FiTXFveoXkBh4VZFQiANsGeyZ1nVPEe16oPO9R8S
 YrD/T5+TJi9e77dZFvyqjITu0+NkIId+PcCmn+iX1/acPaTIc52m6HevTnXPbJolAKjYf0mkjLU
 bnMOKnGHR0xAsuhfz3EzOtLx+b88aHLGr2yC0yueSshVat6R4RjMF4B6dk+IgZOkK4UTlT+Ryl7
 qlM7q+AR76+HaW7f9mSZipJHeMO9Mqcm9QDQiCLr9A==
X-Received: by 2002:a05:600c:b86:b0:459:d9a2:e927 with SMTP id
 5b1f17b1804b1-45b4acff99cmr28162215e9.5.1755722881855; 
 Wed, 20 Aug 2025 13:48:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuoAewrBNnzGm2hSCaUriZzqV+MiOKLl9SnHfqKG67YGuNoXbAEvkG4lp6WKECmF7YjR/3XA==
X-Received: by 2002:a05:600c:b86:b0:459:d9a2:e927 with SMTP id
 5b1f17b1804b1-45b4acff99cmr28162105e9.5.1755722881497; 
 Wed, 20 Aug 2025 13:48:01 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b47c310efsm50431555e9.7.2025.08.20.13.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 13:48:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 0/2] Two minor minikconf.py fixes
Date: Wed, 20 Aug 2025 22:47:56 +0200
Message-ID: <20250820204756.1039443-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820-scripts-minikconf-fixes-v1-0-252041a9125e@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


