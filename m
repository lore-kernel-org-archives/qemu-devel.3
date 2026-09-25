Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EBBC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA0Q3-0003uF-Rl; Fri, 25 Sep 2026 03:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mankku@gmail.com>) id 1xA0Pt-0003te-DC
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 03:32:23 -0400
Received: from mail-lf2-x11.google.com ([2a00:1450:4864:36::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mankku@gmail.com>) id 1xA0Pr-0000mP-L7
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 03:32:21 -0400
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b8e6ec4d9bso322038e87.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 00:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790321537; cv=none;
 d=google.com; s=arc-20260327;
 b=C0E3mCN+UKGQAKVbnlcjNpaAs7NHoKSPbt7tLsj29vhZzr50VGUejnwKCbkCItFMTN
 UBJoms8dP/3d+H5p4ULhu5o9Vlg3Bsfog6CeLpQf3eTD6Pgeh/UCuOnodV3gTiC8vltM
 DUDhw1Co3E6fTlu3M+zIHPRtOox+/yPTluAMHFfNJ+SdwmdaUBMdbV9s9HcJNJLkQa9t
 H0de7wySGLuQhQBTxfhZRqTaKP6j48bnpVEQtzoeU8A5wtympS8+igqXHzLyrC2FOjpe
 +v7hlrCwL7SYuiVg53cFtVMf7qiZfnjIjq/NGoadEFtzRBWf6nEcoHgzmMFap58VLXip
 bgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pkfbhb4Kt0gd4q26HEOIyHUIRNj4QKjgCq5vOQqEAv4=;
 fh=Gs0+7zaMh8a9SJFlKztesr9k2uez6uSrcF4K3+ppkak=;
 b=VWN0xVmjI6XiOACHmaBrv2nTQIKN+sKnfnNVbeBYFmJA6bHcJtazk8MdMkuLtKRbcK
 DOVMXsfOPrwpDJ/V49yRd2lNGlRHWbxCRo4aJbU+CPLgaZl5KgyZMaiNheENMQcWmpUe
 w5zpFMTQufMQ0HOIO2n+pBUecT3mWvfgTH7zVgzfj+9MPnpqo0uzeXlLHIYbBr2SL4Zn
 e6XqmMIeo3gaw+bj2Wc3BySw875DmgbvE70gU9tBjigBakNVyAdjXW+BmPH9YYN/kMdm
 OniRX6bT5/Fe7qqZPGK/iP/kg/Td4KYcu1Fm58zV/UxG3fYlpet3mDURXd7zaSVQzaZ9
 W7dA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790321537; x=1790926337; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pkfbhb4Kt0gd4q26HEOIyHUIRNj4QKjgCq5vOQqEAv4=;
 b=dnTLGp2hNm6FMn/blx9htqNAPJw4KPMQgE/t+X9RSi6MeYfsIp1t5oADkllqAo8HTo
 pLOiMNnMrL0RBRZE8cgJi0qaetDwVGnB70GhjnaY4N4y5EICSOMmliB396RHnb0V9++G
 O0PKDG7AriPp+af1QxVu1fhvWzP8VK2vDL4Wc8r3oKyvRUF/JB+Ny2UKKawR/m9CYTcS
 xaa/FaO+rHvsp7Zu4MJidvAobT0VBXJaG1kfngxZ0vb/MJHdgCmhYBeRSZ+RnzWS1lp2
 egoNJBJzXpYVnV4OpFNMnyfbfH8R/zfPo+OEQtx6/JIk1OdB8oTU7lJPxHd8zlg+Q9L+
 KuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790321537; x=1790926337;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pkfbhb4Kt0gd4q26HEOIyHUIRNj4QKjgCq5vOQqEAv4=;
 b=adYjMu+7xQL9igWCW4z3acCv0S2i2JmCNy6AaWSRg9Aj4rdkiK7MHLqWIwsZYfFNjz
 7fNGvygkrIGHBGptM/p7M9WteP8KZnJMnep3nDrcVLkBc/UU0UPi/VDhqcVwOVjZcgWB
 CzAeG7yQ1Vpr+DwoCV0TPHoxVB7dgJmd4MWiEoCcBVFlYuUHf6Nxg5HUpHphWq4xA9mz
 IyacNpoaR+WL3dz0r2xN0PFwW17pkDQUl4InXhD9KgF0f2N4E5TrsMQq6i967pZZBgOn
 tcStb0QAF/0tHw647Cq0+vm79iGljos0nl8zxn0KBMesbFWBOsDJwbkGcAQLGDet7GtU
 p/cQ==
X-Gm-Message-State: AFuF++mLzcH7xDDBQjK8ziMRgWCwc4hd37Qj2bq8I5ntixqEmWPxzdZa
 12pyVR6iAg0BYr/U7N2MAmjcg1cVM0Sijcrwb2R2C02h+5A2YVQBX5KBSEaFkSAXm5tQqJxuSd7
 pBFrNI87PpW4ic/arWG0jtZX/q1Jj/Bw=
X-Gm-Gg: AYBFou3ixUXyI7eoTax+LtEsX/bYcQ+w90gegsR8VWS9hrk9AbQqfrqL9i7icAUBL/o
 YJuWnTUls+ABTwm6G/EUUFOQF3cY9iNEuSjuwL84JB//z+Slx1Bgtb3uKHiivOQMEqj5ElDja1B
 6ZieUjB0sRlicA1ySEzPruXiM2O3smWlpd6Cp74GhCgnB9P++f8QLYPGPHCrMH+c4xkdieEcohr
 GuEAgiZVPEcH1d0qbynDlctFJOdBngbKVgaNmhceUGXPX4aryRgyZMqwYqNT+mTGLcfWBxEm+kT
 avDhg2uf3GT/Dd0kOTQnT/U/1OdK6DHp2mgKTOF2oI2NRrApfN4jtPQ=
X-Received: by 2002:a05:6512:3d12:b0:5b6:1a7c:59cc with SMTP id
 2adb3069b0e04-5b8df0c6bc0mr1598169e87.38.1790321536688; Fri, 25 Sep 2026
 00:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260923-nvme-intx-fixes-v1-0-fbf0e4e567a5@gmail.com>
 <20260923-nvme-intx-fixes-v1-1-fbf0e4e567a5@gmail.com>
 <arPkoItGqH5MY7TQ@kbusch-mbp>
 <CAO-Q3byewGo8azAhhkHSQKzU=T-h5gose1_=GXZXq3fdvvX2aA@mail.gmail.com>
 <arVkj2tPEtYtM-w3@kbusch-mbp>
In-Reply-To: <arVkj2tPEtYtM-w3@kbusch-mbp>
From: =?UTF-8?Q?Markku_Ahvenj=C3=A4rvi?= <mankku@gmail.com>
Date: Fri, 25 Sep 2026 10:32:05 +0300
X-Gm-Features: AclHuK_K1NT6jm-wszTaBKiNS8b3ZELIxNLOCN5PEhad0MYSSSW2BtskahD_ZLk
Message-ID: <CAO-Q3bzJWY7tmaz708VUd9=i2Uiqw6zB-KstdwJBDkriyCzoaA@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/nvme: prevent cq_pending underflow
To: Keith Busch <kbusch@kernel.org>
Cc: qemu-devel@nongnu.org, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:36::11;
 envelope-from=mankku@gmail.com; helo=mail-lf2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 24, 2026 at 8:57=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
> Are you also using shadow doorbells?

Yes. The ioeventfd calling nvme_cq_notifier() handler is only
configured when n->dbbuf_enabled =3D=3D true.

Kind regards,
Markku Ahvenj=C3=A4rvi

