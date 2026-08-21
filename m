Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A10C5DF97
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxSDS-0003WR-6W; Fri, 21 Aug 2026 12:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sef1548@gmail.com>) id 1wxSDK-0003Ui-OI
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:35:31 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sef1548@gmail.com>) id 1wxSDH-0007LM-MP
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:35:29 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2d01663d816so10839435ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 09:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787330124; x=1787934924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2wE69ZiUcY/ij7KJ9fbiLkQEQT3Ld/w1YzzobrbfgCc=;
 b=prj4BN0UN5EK/anWMWKlbzDBg+ySMviwHHBY02BA9HGuqstMEaAVd3ahufdxxn3zBh
 VT26MD4uYJFFfL9ZEBTLdNEvoT300mXX3oAe2JROPVdGItLpqe32JFHW3v2DRlYNXt5U
 b1lzQjF+Xichh/6ZSk+k73/lcI74v7M/nPk2ShoYtiqL6PY11m0sg0DNVqxTnM/DqJiv
 HiKBxeuDAJu2p1WMv14In+4GyRWrO3A31VbJxMUH4DG7XbAZ+NC+RA23fm1nhRSSH26n
 pkOexZpOQPObQr/u6Ss0/7U5pWPcDttREIA8eReAgsc9l+/dujkEeBzAwGBo0SKbeHTC
 boEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787330124; x=1787934924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2wE69ZiUcY/ij7KJ9fbiLkQEQT3Ld/w1YzzobrbfgCc=;
 b=eJKFPsvVHvNdq+CSH3q2tgVyG5u3YWaCXuFpK5Z6VmdcKAGry2AaS5eB9BHL6gvxCV
 23AcYgtXcFgEBl7snP21IN3K2OwS5aLf2Bn4U2g9BdRjwpzoKeCrTtx8CQ3P2rz9Xjw/
 7uK0IfX04wb/25kwjx69zbiwDdK8thuEPof+XJm1dJH/5vf8fXeM9m3dWPKFWL3aQDGX
 tLZkLuqFLBm59ovjtfmjWCMGcQM2jdYxxawuXKlKXl8QfU2wY6psMRBty35OKTTtA0Rw
 7qfY7iLvYgIIAfWwVL/2BPcxoUPD1+xr2LTx1Nd+20oTRn0wcFcHF88Iqm8N9ppD3f3y
 yKnA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7/EfBWrKBQAED0GixqvrS39CkzS2uL6KRAhvW+tp4SP176ZKOpaT42lGXe28vF3UjNE1DGG8tbBSm@nongnu.org
X-Gm-Message-State: AFuF++kgrDPR2dptjCAZs94w95mpESC7hEnkywwK1D1TmpKZcg9HqI9B
 vBarXcZL87a856hN4HkhneLEXSPJlLv97NufqV0x3HEs+ZZ7DuNGe4BZ
X-Gm-Gg: AR+sD10YfDV7HOzVvNpADW8CtUC2FHeEqWTITuz1awpKcnbuG2T1MiPuyglLfE7G3zT
 1j4C6MYVQczHrcn9+Ma0wd1qh0D/ePfvhXiR235oTvHaqpgdwj+QgidvPULIk+Px6itzfjE9xT4
 mK8w5Cv/EM1tACuybelLG4z5CN1ZLl0RkUTwMtphapV8taNzfl/CYLQT+hQQdob/u6hb5sY51id
 ERFpTK9OdoJMCbH2uaq/2DUwfgWOnvCHQILVjx7gkbJjNyQd6OD8ESpZS+WzT6PJWwe759qIQfd
 Uk24eOtUbbbdNrkB9NWaxQoSGZOzRNkA4IEqyf3iGT2F6odRACCpiHaaM2yC1nKmA8WIaIQxU4L
 ZsBw0dSz+ouWNnn3Ka+IeGLjyCRTbzgsCyzW3Nog3GPEmcVYPQhHpEqxWowJGaRmL6O9pBjb9kq
 6hB+Io5OzcfM/1AskTnQOFF9oDAhZ5UZE4qCV9qGYW/pVfD+YoAceOqMFfJLnjuWluUOUuNIsA2
 kirhPtIdS/DrLcn4Ot2Hye5T/m8y1hfCqX4ogEjHJFBcbudp7zUpIwf085OHtwkD2MViWamz17b
 op6QnYBmHkNMHg==
X-Received: by 2002:a17:903:2c0c:b0:2d3:78c2:1f19 with SMTP id
 d9443c01a7336-2d64b0270b8mr146787085ad.9.1787330123782; 
 Fri, 21 Aug 2026 09:35:23 -0700 (PDT)
Received: from nickhuang..
 (2001-b400-e2d9-9e95-5d55-4df7-34a1-04d2.emome-ip6.hinet.net.
 [2001:b400:e2d9:9e95:5d55:4df7:34a1:4d2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d62e3a2713sm21646445ad.58.2026.08.21.09.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 09:35:23 -0700 (PDT)
From: Nick Huang <sef1548@gmail.com>
To: wafgo01@gmail.com
Cc: bmeng.cn@gmail.com, farosas@suse.de, pbonzini@redhat.com,
 peter.maydell@linaro.org, philmd@mailo.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [RFC PATCH v2 00/14] hw/arm: add TI AM64x SoC and am64-virt
 machine
Date: Fri, 21 Aug 2026 16:35:15 +0000
Message-ID: <20260821163515.12575-1-sef1548@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820124824.618671-1-wafgo01@gmail.com>
References: <20260820124824.618671-1-wafgo01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=sef1548@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

I think this is a good approach. Thanks for working on this!

Regards,
Nick

