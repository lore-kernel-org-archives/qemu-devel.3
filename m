Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0B6C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4F5v-00040r-Lw; Wed, 09 Sep 2026 05:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x4F5t-00040E-1s
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 05:59:53 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x4F5r-0005KD-El
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 05:59:52 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-861f30636f9so84794367b3.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 02:59:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788947990; cv=none;
 d=google.com; s=arc-20260327;
 b=Amid2tC9Ds+svdH/3rt9/kq0FsfuhWl6f29s9fCQjSQvq0Jj8bhS6L2721H4rWoKYg
 SEvkoFOFFsN+9ND0tmaUFlGhr9Awbv0KlGj9QqkKhpFJYwvmGMaD6UFdBJhuL4JZgFeI
 9W7pPmNq7IucFb9BF2xJaNSQ67EIWhtCVQFuXDIMNz9tRCPe19X9tF3ms2xmUS+rpIzi
 Q2dMRQELbQL2FG65WiNZPRnj5xZ/bxmT3lOVWtuy8lUFYgpsR8/dAykxdEU7cYyy9m7G
 et/GunQnF5JY1mfVN9Md9trtjDG5jv0B+6jWQzCSgEMwAzQl5+53ttAQjbwq8O91tSOq
 yz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P0yg9s3f1ChwQ2/M0XR/5eIz10Z+xTKuOJzrZvbx6LY=;
 fh=anZl6Td6NaKjHGFM8y4oK3yu8UEI3L8plTd5OD+C2Mo=;
 b=avG4hwiI5GHqF6imVmysoO6m1CeHGh4SRDk5ynIkSN1tKu7G8jWQfmZcC/5EL17YAx
 ws9dH18QNWfu6EuQKZOUlcXibUuBIx+V6gSMDekigqbJ3JW5fMYadHjzX5i5z07bAzts
 RFtXH/JZHKa8I+xdYHUGs5o4J4d8CnMF2lb3y2KWmnKgt6KtHjnZp8N5kBqLx5VA6ZVA
 QGe84X3JJ1F+JnP1M6omNs/E7Ipq6w8cP4FdIJHkJ+fPGBEs+kgUY7B6g2Pu1ZUnMK3O
 SI7ZgNb8yvzy2ulteGRuIpV7toq4VBT+QKIWW58Xs9s7JQiIC6r7SIH6MAurQfZqdkY4
 VbvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788947990; x=1789552790; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P0yg9s3f1ChwQ2/M0XR/5eIz10Z+xTKuOJzrZvbx6LY=;
 b=QpxhGSu+ETR7DQZPaYPNGFco/LPWWOVzt7gP7HKCCgcyXXXvhGiZvyyuI3zM5dOVsq
 Rv3eY4J/o06Ujn32xs51IJqkdtAK9TtBOS8XZRXa5gswPtNfxzzEwwNp1ZtNZoemI90x
 Loe0mq2KOnV/Zph2Nb/MwKmZ35ylX4kxhhnutHQRoK2+tg0+X2Iyx2q29kwHLsA33HcE
 y9Al0bUyq/eQNBIbeJJMY7olD5hKDOhcYqLYhzIpO1es+iL/NJ7QAuKAaphL7xtQ0wrj
 F4IPBH/JKDNOt9OCX7SAMWvBVAgI/wv2R6LSKE5+IrKFAhCsxlhaY9L9peCeiTrmxf6D
 DlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788947990; x=1789552790;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P0yg9s3f1ChwQ2/M0XR/5eIz10Z+xTKuOJzrZvbx6LY=;
 b=AreB4OjkBgeckSmPpc3Or0R5lhcWJyad7gQlhuu8omw1xZkvsbvJI09bx0iJbhmHZ6
 OdefGZpTjVzhTwuSTLHHLJ4M9ijoT0B3Um+RkbMV+//JOEBq72s+lj2n6wZcmxsCtOq8
 dvz+tE9YyRIsezlFyuR27Q9Ec/bP3tCrfPdeOxa8tdZ/jn40xoUQb+PDQwJwA0fHaBE8
 zH3KJOUw3K7fx2n42knKqC9qk60ZcufBkqj6aTtaFjgRF/mkFh3iJYaed0hcQST8Zyh1
 yksPgRlnhjNvCqhpm6RJtWeHUqnCdnHzbSStFYNw2GV2Dje1OEcClge6VPeZd7jTfbzm
 YgFg==
X-Gm-Message-State: AFuF++lrNErO3cCkaoEcpYvEN8fS246VX3v4I86GGDdfdnmmtfbEd56K
 mnyYcOwBvH88ucJlSwUZjat2jsGOSDYgNMC93t/yZ70Rgxm0tgJgat3AqIoVXJd54KM+4GLbEiB
 lw3+nspc49uZcikowhEeBo4C3Z3uiJ9qqCeP0CP12YQ==
X-Gm-Gg: AYBFou3Rvtu3lQeUvBOAALmm2+rnkUzK/u71MTp4zxv9Yp13PXSrQAhfkji/QKq6HZ7
 q7XeaFoNde/DYpxYj8HsRGLmiVeVtAMWZqGCNFG9rU8xGaQ+8PCFAxPyrh+anKMDD1m+8zd4enY
 WwKOZry3HRZNigyXhhLLCFBE/0M3P4AjD0g9zE9ThIMxU7SyzWB7/Br9a44JRjH8ydXQZv1VjHH
 34L6amLgNMSNZJDOSMrtcVjjcocMKZFwBdpk2Ql+L5o9PnFce43pQYwAVta3hxn6Y8IQ61p4oM5
 LAy3RRlTV9w8dkapbNrE6Km1KDvHnYEHoSM55W+93kFrPOa/TfMlDiOQ6MXbNBSxEHzO2F/Ej2F
 MUK4kVL8XgyRjpCRY5mZikzx8fOE780Njlt53vQE=
X-Received: by 2002:a05:690c:710a:b0:873:5c7b:c0fa with SMTP id
 00721157ae682-8735c7bc5b3mr95930167b3.50.1788947990051; Wed, 09 Sep 2026
 02:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
In-Reply-To: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Sep 2026 10:59:38 +0100
X-Gm-Features: AcwNN1VYTnMJjecseBJVlWFaQCVRd4wQ5Dxr6fveTBL_i2jet_u8ivtd94r_j_E
Message-ID: <CAFEAcA84y8=rx5-r3oA9i81Z_pPNoZejwYVmahVKVDpo=yNqRg@mail.gmail.com>
Subject: Re: [GIT PULL 00/15] Preliminary fixes from "qom/qdev: associate
 properties with QAPI"
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Tue, 8 Sept 2026 at 16:07, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit 55347990687e7bc5b6b0d624f290025726e8fb=
fa:
>
>   Merge tag 'nohmp-pr-v1' of https://gitlab.com/marcandre.lureau/qemu int=
o staging (2026-09-08 10:57:00 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/qom-qapi-pr-pr-v1
>
> for you to fetch changes up to 554a1f83c6118df74b2cb1e4da2271152857b5ad:
>
>   memory: use object_property_add_link for container property (2026-09-08=
 19:06:36 +0400)
>
> ----------------------------------------------------------------
> Preliminary fixes from "qom/qdev: associate properties with QAPI"
>
> Mostly typenames fixes and minor refactoring that were reviewed and will
> make the series slightly smaller on next rebase.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2
for any user-visible changes.

-- PMM

