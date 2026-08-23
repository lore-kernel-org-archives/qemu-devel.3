Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045AEC5DF8C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 10:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy5Vy-0003mZ-93; Sun, 23 Aug 2026 06:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wy5Vv-0003li-WC
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 06:33:20 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wy5Vu-0008Dv-Ig
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 06:33:19 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2d049069377so21276585ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 03:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787481197; x=1788085997; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=W7dhBvPAqB2MrAMT116HezpPmF/UpojLpzKdLrlciK8=;
 b=pNy/N92aBq0br+D8MToWA9hLu3AUZ2j+UUBX3dR552Fctlr8i56BLRJXFFxQYu6nYC
 E5r3iM1ofkz3ii41QeEzyw3/VyAcvCrVrsWwu4sSywPPk0ov+G4PFjSV7bR8STRCpK81
 HyiASd2Lq67rxGbVT+Vx5YA8gSpX3Lb6j+e9bubOMGXfcWqIk8N9PAahF1j8Kp8EDU53
 e0T3MtvJl08Jq+Cbip8keN+11lCiPMJLfX7iRC78ZDSsJ+fgr71u+/LkqAbEwXpAHQ9T
 +MdPm6vdrW/952frdbSrHrbufh+iK+Z8zkS0UsI1uJpWwfXy3uDgljNoN6tHzxHwbomn
 Xcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787481197; x=1788085997;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W7dhBvPAqB2MrAMT116HezpPmF/UpojLpzKdLrlciK8=;
 b=P6n87OKFKYp0VLDxlxAF9HP63ab2JktaWykqHNm0Aq6/RTD+BfEtyD4+H/6D1j+AnR
 dzB5/H37yLaAJ6yjFApJKsDeCuxD6xsSxBkI+Fpbl4Frf8W+VOhiSDgwZurtYa2I6Cxu
 kDCjbEFHje1QrBmyIQBSAXC0LB7CoDN8qwysM5JdvGoP/dEkkS5G7TdgxiNesC6IkaaO
 E7d0pXUoCq3n76bbnLorHqvlZsd+Kk8JRZ3BmY3EhOUkQxvjaZZCldMX+/NFpmdq6LK/
 ybMEmrT2Ncl2CC101QsJJ129J4exFnZi7yfrbIMHOcgFIS+RIrRpVE1x7dP0twLpTPgy
 IM7A==
X-Gm-Message-State: AFuF++lX1U4gq5AkG6STSrl8iIezh3aju55BnOWQ19C699B3w1VgnQs6
 QdZ/g2Rb+p5p6E7qMFD1ZnLDr7JvA3KuyS2h6RbyGXA9SIsc0FrTRSxv
X-Gm-Gg: AR+sD13rn2fKWOErIxA6AG26s9ANkPCslxdkdq/wYkn3v21KafhEARBMJvfKjqCB/gj
 L2RaaF4jFP48UDJppCjR3VthWO6bX+4drHrbL3RL8mdaU2Est0uGUVcmTKp1lL4NJS2v7NFo+LL
 W+N3q+UYKufQzW6e1POiw/ugCHnT2AIiJ/Ka7g/f9grBPW6cZmg3QlPQ6Jb8dpT2RiKNi82sYuv
 QBmKl8jB8E1OXmDsfAFGJ3MLCnC96TQmTfp9/v+yU0Jw8yvUdh/0l141lHR8in1wAOswNT+iUti
 EJ7jrrERt7GgUHFspGRSBRjJcTTUTBlLWHGpqEJEhEX4LvL+59K1co0VnDxCc27k9W5i7AfM55V
 05AkHKh4XdtfmvQPrrGFjKxfftoAIfMjVv9WF0Cp5kY8nShNLOF98v7ypxEMwJ2jjxONaC9yMJf
 xeMBTOXjN6ib6dDY89vU70m4e2WApVFM3x9VVgipmBadqUXt48suCltbwmSs7SMkGjYoBX
X-Received: by 2002:a17:902:e546:b0:2c8:2808:3ec9 with SMTP id
 d9443c01a7336-2d64b0c4e5cmr280212535ad.12.1787481196594; 
 Sun, 23 Aug 2026 03:33:16 -0700 (PDT)
Received: from smtpclient.apple ([117.55.237.216])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f922ac7bsm14389179eec.25.2026.08.23.03.33.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 23 Aug 2026 03:33:16 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v1 4/5] hw/arm: Add Axiado SoC AX3005
From: Jack Wang <163wangjack@gmail.com>
In-Reply-To: <20260820102132.361642-5-kchiu@axiado.com>
Date: Sun, 23 Aug 2026 18:33:01 +0800
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Kuan-Jui Chiu <kchiu@axiado.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7312F05-0DFD-4501-A59E-1DAD8C999785@gmail.com>
References: <20260820102132.361642-5-kchiu@axiado.com>
To: kchiu@axiado.com
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Kuan-Jui

I tested this series with ax3005-evb machine,the initialization did not =
complete.
The process showed it repeatedly executing in 'ax3005_init'
> +static const TypeInfo ax3005_soc_types[] =3D {
> +    {
> +        .name           =3D TYPE_AX3005_SOC,
> +        .parent         =3D TYPE_SYS_BUS_DEVICE,
> +        .instance_size  =3D sizeof(Ax3005SoCState),
> +        .instance_init  =3D ax3005_init,
> +        .class_init     =3D ax3005_class_init,
> +    }
> +};

You add instance_size here but forget to add class_size. Then qemu =
defaultly use SysBusDeviceClass=E2=80=99s class_size cause of father-son =
relationship.

> +typedef struct Ax3005SoCClass {
> +    SysBusDeviceClass   parent;
> +
> +    uint32_t            num_cpus;
> +} Ax3005SoCClass;

Here your struct apparently extend SysBusDeviceClass field. I think it =
is the way why previous repeating behavior.After add class_size locally =
and rebuild the the machine completed initialization and responded to =
QMP commands successfully.

Best regards :)
Jack Wang

