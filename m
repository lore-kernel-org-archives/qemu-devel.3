Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7388ECA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 21:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEYlr-0007Bs-Cc; Wed, 07 Oct 2026 17:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xEYlZ-0007BK-Py
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 17:01:37 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xEYlW-0006Ll-Tw
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 17:01:33 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c2a832c6554so356518166b.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 14:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20251104.gappssmtp.com; s=20251104; t=1791406888; x=1792011688;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x6A6EGB3o2xrtcu4CzxiU89cSOiPdlBPE+/1hul7RYs=;
 b=fKIbUun6q/0kqrx+KZtBi/2FcJoAXw1i893fTt9ThQZDORO1LCIVLGWBliGWFcBq5T
 WwbS6Dslxl8aslr8+ZPn2/CQqMxKYhilq5OvArVElu5O8taetD+yZGvvvsUYZVEIGFC+
 hA+Tf0SlW7qolgrMtDwlnHc8WynBj72a3Ytlygp1ErjUPIxjKilWUK7yAyIOqBiwtoWu
 6CYdtYp8wCj8VWWOXTknvm3HUC5bJqgdopjkgor3zh2ZiWX6qjWfUGJSmK/JX/4fNlme
 fjwBIs9evsyzlDrofY+L+n3IE41+uP1o1FvKDILUk3UgxZoX0RGfbh0eztnFn7KWrd9K
 xqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791406888; x=1792011688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=x6A6EGB3o2xrtcu4CzxiU89cSOiPdlBPE+/1hul7RYs=;
 b=qJsHkGnlKgGQJccw9/dOKHEo2U9px5ybQJrCpNaY5owpONv3z9Nm6XCLmxORJoEI7W
 3H5xTO5rSKyjgPmbTnUMtIICZx6WtsR/VO6dtiSANSAX1xwvDoKgN35YLVeWBUM6XdOM
 29HOC0Nkr7PKbJV4hoeyvAVR527B3bqg8PxocGoHRXA/ejX3i2V38kdRgMZEUOnV4kvl
 imUl4zXBrhcxZw5cPpeZYrhAJQLT2JUt3+71sXteS1xolVsriLCRwf+IgVu+BTQSaE6e
 w9qrGCzWkJmPCLK4qcxEe91yV3WAkhIL0SsucvMcWcE7v/GUgTFnk1YyaNz+7vOdJsFZ
 REeA==
X-Gm-Message-State: AFuF++mOX91fICRRNNa4gb2jghZFgAYWgOCTDR9k5MVnPMv/eie0MyFu
 Hvsd8TATBC64psm5q/qaaLf6Xj31XfTMJiL8d7/YpfaMrNe+fdBCMFSOCyIwqyWqwGI=
X-Gm-Gg: AYBFou1hDysjAxdFk+y1OCUYGapVW7Rrl9K7yk8X4PFbFI4ZEmOypzb29P6E+TqYFAI
 OS+UzrIM7v/dA7KqZAu2bXbTMBtfe8E6yicuuJv+xd/M438vBTd65DWfJcMCfzFdkWmh1gOAYZD
 BHi4AyPb3WsUHTrmYq3D1Gmwk4z4kwpXEi04biOr2R7CY+m97IxNq5RP1P/i/8N7/u8gUB55ojH
 LyRiNkj3CX9hcBeaUBiyxsrgWMJjHynbEacmYjjBAC9B/j0Ic6D8UI4GicQ65wZBCzroM474dpS
 739L1zvqGqjgi+R1Wpkofr0I8U4m8FR2QQ6fQ9cix1he4INQC6VjDthgSpB+Lbu+NczuZ6kJO6V
 1K31Uihb2vY+uzdzqSgScVagPGh0VISIxaJtThU/dBTyNS41ncEnCXapM/YL+N9iHKmR77Y2S17
 3JzadWEcVKIc4Ak9JPvEUd2X/I2nbSM3KqPc/nlnvxR7QbULb7x4ZKS4aDVg5vK4MnqfLsMvaEl
 xB9FkBQQ9vmsJE=
X-Received: by 2002:a17:906:e107:10b0:c31:866c:9696 with SMTP id
 a640c23a62f3a-c31866cb1a2mr163041066b.31.1791406888391; 
 Wed, 07 Oct 2026 14:01:28 -0700 (PDT)
Received: from node-dev.home ([2001:bb6:1895:f400:49df:f57b:ea5c:f31b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c318c822527sm47468166b.12.2026.10.07.14.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 14:01:27 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, mst@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com
Subject: Re: [PATCH v2 1/6] pci: Add device ID for CnuasNIC
Date: Wed,  7 Oct 2026 21:01:24 +0000
Message-ID: <20261007210124.1224135-1-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAFEAcA9AP3RrLY4fzvsc9Bx845tiP9NXYo1CJ5Fb_iVePQKc5g@mail.gmail.com>
References: <CAFEAcA9AP3RrLY4fzvsc9Bx845tiP9NXYo1CJ5Fb_iVePQKc5g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::630;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

> I think it would be better to add the ref at the point where
> the document it's linking to is added.

Thanks for the review. Fixed in v3: the documentation links are
now added in the same patches as their target documents.

https://lore.kernel.org/qemu-devel/20260929202358.725310-1-weqaar.janjua@packetfive.com/

Regards,

Weqaar Janjua
Packet Five Networks Ltd.
Dublin, Ireland
https://www.packetfive.com


