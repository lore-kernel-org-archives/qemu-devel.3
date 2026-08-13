Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D48FC5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuW58-0006IP-3C; Thu, 13 Aug 2026 10:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuW56-0006IA-W2
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 10:06:53 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuW55-000402-Eb
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 10:06:52 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-ca00f126b7eso618026a12.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 07:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786630009; x=1787234809; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UAfpi6kIdZDOLlK42hZ2VUhvVBWokX3ThiTRbbcxf70=;
 b=zdTkAYJxwZxM4l+YyBmIQNr98j2Fl9YbPjmqA0KBSt/EKE5kA8jAYkp/cRVTF1E86W
 hZ/Uy02IrrEcpLi5RkmNWedlTtzsjXu0lHk2cQ1YSlo1RfiYHout8sP1OPXz5YXOl+sq
 J60iw9GnGPm+KmN0XMpo59tO0/XDa1409lgeR3RM5jhl/ONWGd3my6sCRRg77I3FW+MX
 l0/36dC/JVT05PohFB2dRoCeGjpLBARiTnu5N3vihyRNdboqUfCcMuQvM2x1ppCjDe/O
 4hRT+rM84JTRb6dCnpIK5nZ+6EOQWPbHVTWUWhyI49QAr4WyAxH4I1Nv8bMAjBLzZvZw
 +T0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786630009; x=1787234809;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UAfpi6kIdZDOLlK42hZ2VUhvVBWokX3ThiTRbbcxf70=;
 b=nXLjPN03mlKNxhcvi4sayelbp6+vz9f6zPH1IVp9q+GcxxQk8cDrGbiuzdqAVLOtev
 jrtYjCat/BIo1+aFJ8lqgzLPLYRXqHkmCWoNkPjB5ECR14tpXxm7j73C4aRLhX8875AQ
 9JqR+QxLBnQGqxZchUbT6Rqe4AxJLZ543P2Mf25qbc9cdHMbEBqi9t+Sm+dHun9+LNxF
 QBM2Kjnor6qH5wScHUJNRGyT3xxAQ1+UnBlGn0/0RvO/VpuvaWNwbVXrkjQAX7DaSU6S
 yseDIg/O9oPw/lZB9xar1UDGC3TBG2tKKn3xnRemYPnlVNbVl4s5RcSvr42Qqfu0O0of
 k98Q==
X-Gm-Message-State: AOJu0YxygVGrWolD21UJpSwSg2vCHjGv8nug3fczLz6VSq4PnhrH2iYs
 pItTlBrpUd7tUs19gQoGdl47yo21CSa2yBx5wZBc7FwkcZcGPFWDDOlPtSmQPaNVe5uLKUGTlc3
 Ga3Rq
X-Gm-Gg: AR+sD132F5u7n+Eti+KtH9ME7bBZEy0gyJZMENB5Jr/LjFcfqpKTbF4HrW2b96LaCQt
 Ow9HE04T7a2TaGzR0Nu2JwT9Ix3UMgR4GUUAoQhElKJsP1VggaufsRoZC8BqlLySw91t3Vs1D+1
 GmpsNiXJ90ws3zMMq++G9ti56jrtPtqCc2+8evv+pjevE984Dzt+O1vgwAZporUhKB2mO7mH5CC
 L9JA6xD22tfMmbjevg7j3+Wrz+tBBYyfoVD36161a1kpO72mGpDZ1rDqV5NnAJ6Kht663FUJNWs
 gU08e1b6qEOwEdXl7plSDXJodWqrOXx5FEIeYnTVbZ4Mh+9aZpsjFEFIgrBox6AvGHa4Ls98It+
 QabxCj2wSg15nDYJ0+B5Vb0YteCboYY7wk0ktSrkQOd2ffZkdg1cPF919bcuMfZiK/wjgnnKyAn
 IzXUsnrdUeHz486lUWxniOKbK+PsRpGloK/vmAawWVo6+SLBGkLolmjQ2Tf/O1WXdwXbb2yNJoR
 xbvZrxDBXq7q5f4LxyqqBZTbyM6
X-Received: by 2002:a05:6a00:6c8e:b0:847:83bd:6671 with SMTP id
 d2e1a72fcca58-84fc6e286e4mr7438335b3a.19.1786630009156; 
 Thu, 13 Aug 2026 07:06:49 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fc5a1cd63sm942487b3a.34.2026.08.13.07.06.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 07:06:48 -0700 (PDT)
Message-ID: <2a9e2074-73ef-48ec-8797-e3a6608b11ea@linaro.org>
Date: Thu, 13 Aug 2026 07:06:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] s390x queue
To: qemu-devel@nongnu.org
References: <20260812171707.1605637-1-farman@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260812171707.1605637-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/12/26 10:16, Eric Farman wrote:
> The following changes since commit 3e3ccab106f879b1512f8e0d51a827dd4de30e22:
> 
>    Update version for v11.1.0-rc3 release (2026-08-04 15:36:08 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/efarman/qemu.git tags/s390x-20260812
> 
> for you to fetch changes up to 9b3d68edb24d4e04f49822c6e11641e4eb23dfd5:
> 
>    pc-bios/s390-ccw.img: update s390x bios (2026-08-12 11:13:28 -0400)
> 
> ----------------------------------------------------------------
> First batch of s390x updates for 11.2:
>   - compat machines for 11.2
>   - allow guest backing with 2G hugepages
>   - fixes to TCG (and a couple tests on them)
>   - hardening fixes in boot/sclp code
>   - regenerate s390-ccw.img

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

