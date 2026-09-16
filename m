Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B771C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pmU-00068a-Tc; Wed, 16 Sep 2026 09:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pmT-000685-Ay
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:34:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pmR-0004uU-Sx
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789565671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Y/si/O7hNP34haeE9cgef8dUMSgBPAu78EkHUSAG4qOrX9rDaexIrc0++PZObhOMolEYLt
 mUzD/mvfSAinFfc2jlBaW17OLWKBY/uS8I0ktPCFVJ8+WQ4OJ2/pxbQN3y6j7UJuKSgIEq
 vPolfX2u43YxK2w5u+29UI4hwNdSXXU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-EprJf5pfNGiw8Mek6yPWgA-1; Wed, 16 Sep 2026 09:34:30 -0400
X-MC-Unique: EprJf5pfNGiw8Mek6yPWgA-1
X-Mimecast-MFC-AGG-ID: EprJf5pfNGiw8Mek6yPWgA_1789565669
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49e6c17ec1dso48185525e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789565669; x=1790170469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Y9LDWkFtK+Xafy4saFMZPKYWBsJjxFzAZ/ZPUrVhYYifmYy0ElE9mpyKfB9j9wK7OB
 2usghCClbGcOss17Gs9fo6Us3WgihWalEJKXvAEXqdhuCL8o5Yi3vIXHQL3cwCPUglJr
 04I0SJHt3oT5yzwk3RqqZzwTXeMIh2XeR9spLg3SWC/Kitk27e36PB+ex8jE114dSaTQ
 47/zo7SO/Mj+rRafsHYKKAAtnEpqim3OHifYp9leECX6Okhy+SG3N3tIJfjR9cwmXhpP
 sYkFHVXpZLtubHVK+Nr4WmXbCALeY+gOXHoP2utVGY0+9dVgezwVDVo/ekXD2sPsMOH0
 AO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789565669; x=1790170469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=XHX/wG5a01ppBbEuNnyGaAbXWFYO+a26ZfUMslzF6cSDC2WNYaRY1BdiyNnwpZZXi7
 Xp3kw8yG3iVLoxBFgxAI5t95v7gcs7mOau61ljae+R3OWCihZUah8gOCFCK3veMAhcW3
 B6mQZYuZ01xsPnFtKz2Vkp0hxyvsvCmw5pGAmcy5IG5LEbDGWorRGB05WoO/RnjnCCwE
 e8b/05wjxQPLRPWvn7k6FisyjlON/bJWGhpoknvynosKK9tjyboKdbll50RoCvkoOWEC
 M6qi/LQPGuvg7eo3aBFtfCAwDDgycMIx13rV7Jspq4ma1VFZgtpdLzCJ2GUnRWb2kkXU
 Sdxg==
X-Gm-Message-State: AFuF++kUluLWc+P9qQhlGGefs8cHA/Lw6yTCfqlttuIPksLKsvU0imw5
 f7hsvGPAzNPvQR862cYO6iYu7f87X6Bq40UXZTWjiYbBxk/azWVXFDJDPyQbU37frwUrn1xjV1W
 Gyy5Q19TkpuVOm7ww90jqc/Na2gJeHzM9WH8M/VAJZDP/p9cNpIZMEYbx
X-Gm-Gg: AYBFou3/w4p0NkDCfNljEwRXHBth5m4Z9Jo2kEUiJjEtYEJ+mzN9DDBA9CwVosyksQl
 tOkJs9Q5ytAa7S9UBrLQns8NkCC0WRctK0kfbb8ez4c1S/tLAGXTsLmWda4ZH9mgBWcRHSQDrTN
 Vsr6rmjmTf109xIen61v2h0tqn6HQpPzYqwTzMPgV82oGiviYI94vZYTojF13Axii1JqFW8XWDv
 +OrDH7pobWaOSkUNyhfUm57rP1kmRUCYD19JxV7QVMemuq5wQiK4yBTdJzEc4xWFREfbZFpbsvH
 tyDjo9/krPIE56AuqEcBWHjHtgBrGRUciKsJiaQsQiABRU0VzbnS1k4tcH/1nN0yd4ePpN9kD1a
 36dxXRCUSOwCSFSf+TP1BBwQg7MF8kdt3u9p0ofCOAOzAStchBQ/U4dZfKXNivVgPHt/K3+pAwx
 Ofba6A
X-Received: by 2002:a05:600c:3487:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-49eb7326671mr74231335e9.10.1789565668969; 
 Wed, 16 Sep 2026 06:34:28 -0700 (PDT)
X-Received: by 2002:a05:600c:3487:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-49eb7326671mr74230285e9.10.1789565668555; 
 Wed, 16 Sep 2026 06:34:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83d9057dsm90801085e9.3.2026.09.16.06.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:34:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Simon Scherer <scherer.simon89@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] target/i386: Don't clear C1 for
 FCOMI/FCOMIP/FUCOMI/FUCOMIP
Date: Wed, 16 Sep 2026 15:34:25 +0200
Message-ID: <20260916133425.881937-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911105811.16854-1-scherer.simon89@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Queued, thanks.

Paolo


