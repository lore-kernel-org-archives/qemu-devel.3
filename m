Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92252C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnH0P-0004rk-Kr; Fri, 24 Jul 2026 10:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sef1548@gmail.com>) id 1wnGyg-0003jC-A3
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 10:34:25 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sef1548@gmail.com>) id 1wnGyd-0000XS-Mz
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 10:34:17 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ce87c7e3bbso5481315ad.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 07:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784903654; x=1785508454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R4OEXAQ8zh+GTiGPwGjPZb9CAH0xTF211/iDaSq2t0g=;
 b=GH5aVbl3eFfH6Sb0bksHIYAckbNhyRIvDbdON4hJdWpSFbjGFpDa2lFmLdeYxz9zH6
 Un22M7qg450qhIxWk64n1PlFW4ovjwrcukcEjfJ6FlWKbuU1cFQq3rdfXaAAsWKm8Oet
 P2f6VZrEcoSiwzsCQwxgEhDzu+M6JWiN6YWUQRAMhcYazfId4d0+y0t6XYa52NC0W0OZ
 3gNZts/oFjhsIHmubbvSo1Bs0MdKcbiYoNk6SlRNo+UgCKkzV8soabU8jVDhKwPGdASl
 DvtA9JAM417Qg0NOt9a/AaZotBtdJovT/1frblMzQ/498NDg9806Cpg33AMtFxRiL3Mc
 u6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784903654; x=1785508454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R4OEXAQ8zh+GTiGPwGjPZb9CAH0xTF211/iDaSq2t0g=;
 b=WnBMqxM/uFoHCSLSfOXCtTg1inf6l6f7es69G08mFQSrgqGIyYFCv5nNv+U6YsvfuE
 3bxA5c1c6VqdMWyvnATh+DsdtZd75FEgvH3Z18yrUPAPCqd6lLZQGQZJ6pglEZhrTbJI
 kh87DB3IOoM9lqAp7Z6uZxtiaq0b2syJLX4uHhqYmwuudPzbhGAiXckmhPO/OJlOsjFf
 fmEEPhrsbcSb9cg3CDJMyaPAyQWs0RFZa99RV8VkmkVgGXy+b35tQiowqjYlKq6KC3Z0
 RXhSBrXU3IW0ue9pK33lHzemQwke8QBw4zgggEGceDVAA8xLHyTg2CZAgJruJamRFtWM
 QHXg==
X-Gm-Message-State: AOJu0YxVb7sAuK+SbVP9fCu0m6Z8ZTj2d7zMXUobP1puK/TM+pzcawra
 QJtshONncAJ0xQ22pMmeONv5izOJYpjculChVUAZgK07IAjThpDNqBSM
X-Gm-Gg: AR+sD11RxNgQDFn3X9kw9/TUt4jcHQTNxjFrMdXqtowq11USTVMGIUwpZ8ogJNEuXZx
 jZ8uzamZ87/2ei9Lngz5h+CLPjxNCBK7CWpvcAcxM11oP0HTVnx9CTx4UwkCKS52YAHKpCYpMEm
 sf8F9WLgqu6kqpEqe1vh5qtSA8I8RDrMkyfa6DjwNfk+38WfhBgFXzK/K8HfLM1Uqlqk7V3l8L6
 T+o57KwEbrbTaJyPjWCd+0k4YE6uyoatN4VKEAvKwzDdT+b97cbuXwmJkmpvNw4T9/0vSETRIIv
 Riw6A81d2EL2M7CDpjoRGXugWisitqD2pm2WL/Z7QS6Id34G3S8qQqz/YuFraX4YEIUOtMRshRo
 VJbJYQ2ytKoPJUCJUeUWi600e+zosUnhsQktAu23FrEnCmviUWiJ41hbGmyGrqedxdHJiIQEAVQ
 Vwm8EAgQJ9JIv0COCoWTOf4NpA2HqQMh08rxxrZE3hcTcFv3tc69L4/0meJi2xdYHoIzP3
X-Received: by 2002:a17:903:1250:b0:2ca:d91e:bfb4 with SMTP id
 d9443c01a7336-2cfa74e3b0dmr84212905ad.24.1784903653798; 
 Fri, 24 Jul 2026 07:34:13 -0700 (PDT)
Received: from nickhuang.. (114-136-139-219.emome-ip.hinet.net.
 [114.136.139.219]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf8efd80cfsm52507735ad.25.2026.07.24.07.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 07:34:13 -0700 (PDT)
From: Nick Huang <sef1548@gmail.com>
To: sef1548@gmail.com
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] fix BCM2835_I2C_CLKT
Date: Fri, 24 Jul 2026 14:34:08 +0000
Message-ID: <20260724143408.175870-1-sef1548@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724124220.24152-1-22925483+botszhuang@users.noreply.github.com>
References: <20260724124220.24152-1-22925483+botszhuang@users.noreply.github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=sef1548@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2026 10:36:04 -0400
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

Hi,

Tested-by: Nick Huang <sef1548@gmail.com>

Thanks,
Nick Huang

