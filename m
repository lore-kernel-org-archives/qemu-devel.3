Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4F4F9936C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrzM-0005mo-PD; Thu, 23 Apr 2026 07:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrzE-0005lq-JJ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:12:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrzC-0001a2-5C
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776942763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pQj9Lid1x+fDjXB6D147jsGj2fGp3a2IHvbjQzYCQ0s=;
 b=c01IfJacxHgV4CFRoGWo1Q28t0rbG0U1OSUKogpr+cYtNsbPYExqGCtbTfKKmUlLOYVw13
 y4HHJDQHPNovJL6sWHKsOoZX0/zbpNDO4s8KzoRkf6pULauggnwzff9RVH17dfSAkG66bm
 VntbQMM9DFCO0Ov7XKFBh/B2xt29SUQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-sytsnvLAMey3HgRXz03gVg-1; Thu, 23 Apr 2026 07:12:42 -0400
X-MC-Unique: sytsnvLAMey3HgRXz03gVg-1
X-Mimecast-MFC-AGG-ID: sytsnvLAMey3HgRXz03gVg_1776942761
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48a5adc141cso11792915e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 04:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776942761; x=1777547561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQj9Lid1x+fDjXB6D147jsGj2fGp3a2IHvbjQzYCQ0s=;
 b=PlQViFnSGv2ltQZfKtH24ajc8Vou4BgB+dHjEZkv06nw/NA/FefNeuxjh9LarVCGHZ
 9BQQEH7c48ZT3wi184hQNAVFy2kOEVdrQEKwW9AgNui+DC5RWdvyHO0E3bjST9jUON8H
 6aVY68KxkUUqii3zA8+q1cAwTYAHDA9uw3m/06nz4WoKEWbC1pxCfJWdhkfARPHwq76w
 32uduAPv1IKP9xEpEdrmQba5n/XTbjaj4nv6k9p3V73IK8m0499Zk43Wr89DPqHA8qv4
 1iYCejMyh6LdAQNRAQyjEXJ4bdjyy3yN1H7PGTKj8B1Oh7jbZ/P49l9zCLEt3IrVeGut
 f83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776942761; x=1777547561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pQj9Lid1x+fDjXB6D147jsGj2fGp3a2IHvbjQzYCQ0s=;
 b=B5T3gsGM0ciPTs80pQbkiiWws2Pmkax9ENw60VYya5ow3yPng8HSu+4UzRPHnqJoN+
 f6fLZRWTim96UndzApaEEglFJHyX5d1ZG8yZsM5MSUt9Unz3LsoN/o+u0lz2th4y9Gaa
 a2IoDB+CbUyTiHmFgJohN4l3w0hRZqYXUcqGiZ2pqhKx442NF1h99cHvgw024++/01yV
 ZHWSuviQCsCS8iksSt8+YG39W6n5/ZYmTfEuQoJov5LBebgNGdxcXYJ+my4/S4vRU446
 vSEjG1jWVM6JHgf4MkSjxfbdbZP+AnlZGySH6HhaKJ7Tdfv0GH52mfzTdEYCiKIf6+ae
 idmg==
X-Gm-Message-State: AOJu0Yw27Zcgz++SsUJHV8N/ecQEK7/xbg1S8+YUFOcF6lVwOhladA0W
 cQBRnBPaQSRJW5/KI9tchXBmX910mRx96GmkChDMqAsvBabm8bwOuUlZ6H2aqF8lX45f44/RIDX
 7iGTTN8zHWeLRlDOR8YpB1n59ylbukbsdcfAQj9/s5fvy3UBs6zpkONRN
X-Gm-Gg: AeBDiesdCt7O0QP684rIpKUmvUbwBI18OgV1OvfiRcFk7/vbZp7zlnRb1I6km12U7wA
 aJAZzJyhdmv8bjElTC8zhTgDjEPO7xtAH6EgFPSh3zqWIe2Ryio7tVV9loT5noDPeC0LssFEP99
 H32Yqj7WJue5p/eWKxdH1VKrH0FpZyOVVKfTJJjSgWZPgjoxnXsXxGpLpWVTPIMvPH2OcFyKc3v
 h/kiaXnlRwHKfr8TWro/z7ea4SlQytIjEHgy9/oWApyA/NUlSdPkYdNmbkhlHOcgZmNg1kWoh6t
 I3Xt7MB5viQy5CcQDQeBXXn1uY5+jVdL2X4ul3UU9Y/9BVd+h389IfKX7N/mszN4Nn2xinP5+HH
 AQRIphZq+1pqYeij+YFZdz2Ny97uV48LmWRCTRSS8bodxOmcp7EQIvpAdVbZVqoF6KewUDN998e
 zOqxjrfU+1EtSsaYnaBhUxjVMAyF/eUa6ZQTQ=
X-Received: by 2002:a05:600c:3b2a:b0:48a:534a:eed8 with SMTP id
 5b1f17b1804b1-48a534af0ffmr180058895e9.1.1776942760741; 
 Thu, 23 Apr 2026 04:12:40 -0700 (PDT)
X-Received: by 2002:a05:600c:3b2a:b0:48a:534a:eed8 with SMTP id
 5b1f17b1804b1-48a534af0ffmr180058585e9.1.1776942760302; 
 Thu, 23 Apr 2026 04:12:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb77b001sm243348605e9.3.2026.04.23.04.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 04:12:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: Re: [PATCH v3 00/37] WHPX x86 updates for QEMU 11.1
Date: Thu, 23 Apr 2026 13:10:12 +0200
Message-ID: <20260423111011.460531-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I have started reviewing this, thanks.  Up to patch 17 it is good, though
we want to tighten the MSR configurability up in the future (please
look at KVM for ideas).

If you have any more changes, please either wait or at least post on top of
those first 17 patches.  I'll focus my reviews on both this series and
MSHV in the next few days.

Paolo


