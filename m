Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B45CD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ1HP-0007sv-77; Thu, 21 May 2026 07:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ1HN-0007sL-TY
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:09:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ1HL-0005xA-Sm
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:09:29 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48e82c23840so48477615e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 04:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779361765; x=1779966565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIXb6LsdWBCZzRexixVzsx2M8yYhJZSjKJfBRZQ5Plo=;
 b=jxnwzRcuTsihQgKFtW8B3eWHH29AyAbwQkXFqf94rNCbSCz/PDGriBGxt7hr1zOmOv
 1oRPImuEJnQHs8mgnnN8pcmN9XsFim/3dwJzBnSV6c7p4rqRIxvGf5jjlF8x1p3sYMsf
 f6EwRTnX9Fl2wUZ5rT2Kc4LNZjzeGb5viGrd8fm1Kov3ZOy9EnjO/K8mT7Utg+N+/fBV
 SYL4elhg2WRtZhVoSzK2gFRKHPJjfLt2ad0JtLqgE0GskLpl3BFormXXGgxuHev10o+Y
 fUcITg2K/xl4B9swIsnCpdzS2fxfBP2YwIWjY3llDmM+wA30pdEeahmeZnBHBhsn2iOY
 w+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779361765; x=1779966565;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vIXb6LsdWBCZzRexixVzsx2M8yYhJZSjKJfBRZQ5Plo=;
 b=Xtgu5+JFVIU8fpSWTF1M/6+m53SEdhBkWD5IZLtGzbec2z5BVMhpK0U3oDimtB+zll
 gaxiRu5DYxEMxP+mhGWlUimy8t+vUpay5eE59o5/GqaXdhJUAIqbxt/U16Pc8RHED8wv
 Bw7DTGCe9WUKQVXiStzAul+t7eihF+r5zkpV3N9MKmWxvOr6HXklFlRhYWGxNC1ROETm
 87xbM4qDrpFZu2szWEiNzzEdUB6aP8XfScgikBeyeur6p2KtTk18p/LcXHJxEluhs44c
 potljcujQWsH8pqOVg2G7ftW4uXZ5qssdukahyzGTxbwN86O8Kwc3tLaFNIydVoxyhYb
 L3uA==
X-Gm-Message-State: AOJu0Yz5VuD7JGu4UORN17mkJr75k01NOH6ZxI9HNcEPL7PlGF4BToko
 jydxkb/DBlltf/PDYqrljKS1XtvxSvqVfUZ/CRz/74vq+tLHq+6Q5VjdUK7LN4WbIaZhrq3yDly
 Co1gMAJ8=
X-Gm-Gg: Acq92OG7ZRR+bRwGiU4tBVerAEpzbd233aBGmw2FiaL7NOxvKCjtyYaq6c52aWR99Gd
 N9eWPcNpapDhwJXO7PeNHkXomIQPm9m+mKQTLLFif62SzWq4NvoyJPPe+2pqVB8Wx/j/10+OzWP
 sFh2uRV7BJ78zaAP4xuxIdg8MsifP/9fsu0SbAL5nBpS0F44zAcjnLTy/CPr52HmWVExTZAw5At
 7nZ3Izm83jMKlU7fKV5VCeEyjaVlGWog1sH/QdMnxdeBzgTu9iaE1bGBls/DEZDDPArMwqlSUbJ
 gCjY1yJJnZfssU5pr7w2Sfs/ms7cJkBVmZho0CErUdu3A8T3hg4POILTKeDDmhXuT4D3XDpKKvH
 ZjnkG6Pf/1PyJeKhgNWg7N0unVuFVMCm98CtY+NiuOot6Fk7Hb5z+ZtEWGWk7rH5eq/GPuRoQjh
 fFjPOJQvb2AT+nnr0owxsbGIs=
X-Received: by 2002:a05:600c:1909:b0:48f:da34:ec4e with SMTP id
 5b1f17b1804b1-490360a8707mr37219645e9.19.1779361765420; 
 Thu, 21 May 2026 04:09:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d44d7dsm65404745e9.5.2026.05.21.04.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 04:09:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 89B9B5F886;
 Thu, 21 May 2026 12:09:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Mauro
 Matteo Cascella <mcascell@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: RFC: GitLab issues for security disclosures
In-Reply-To: <agxzKzzDOJm1EU_v@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 19 May 2026 15:26:51 +0100")
References: <agxzKzzDOJm1EU_v@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 21 May 2026 12:09:23 +0100
Message-ID: <87fr3low7w.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The qemu-security mailing list was created several years back now and
> traditionally saw 1-2 disclosures a month at worst. This was manageable.
>
> Since approx March 1st, the new normal is to see as many as 20 disclosures
> in one single day, more than 200 in total now. This is unsustainable.
> I was thinking we needed more people on qemu-security to triage, but IMHO
> this won't really fix the problem.
>
<snip>
>
> Some key benefits of using GitLab for security disclosures
>
>  * We can trivially make disclosures public if we classify them
>    as a non-virtualization use case, or when the fix is ready.
>
>  * We can formally track the lifecycle of disclosures through to
>    the final fix, for both virtualization & non-virtualization
>    use cases. The only difference will be that the former can
>    request a CVE assignment
>
>  * We can do reports/queries of outstanding issues
>=20=20
>  * We can more easily use automation to process issues
>
>  * Maintainers can see bugs without waiting for someone to triage
>    and forward it on their way.
>
>  * The small number of security bug triage people are no a bottle
>    neck anymore
>
> Some downsides/implications
>
>  * Every disclosure in a confidential issue will be visible to every
>    maintainer who has joined the qemu-project repo on GitLab. IOW
>    that is treating every maintainer as equally trusted.
>
>    We do have qemu-security though we could be mailed if someone
>    considered their disclosure to be severely impactful but the triage
>    team can't make that decision.
>
>  * We must NOT grant membership to qemu-project at a Reporter level
>    for anyone whom is not an active maintainer. They must be limited
>    to the "Guest" role at most.

We have currently have the following:

"dgibson, dgibson, 20"
"Cleber Rosa, cleber.gnu, 40"
"Stefan Hajnoczi, stefanha, 30"
"Paolo Bonzini, bonzini, 40"
"Michael Roth, mdroth, 30"
"John Snow, jsnow, 20"
"Daniel P. Berrang=C3=A9, berrange, 20"
"Thomas Huth, thuth, 20"
"Philippe Mathieu-Daud=C3=A9, philmd, 20"
"Qemu Janitor, qemu-janitor, 20"
"Richard Henderson, rth7680, 40"
"Marc-Andr=C3=A9 Lureau, marcandre.lureau, 20"
"Cornelia Huck, cohuck, 20"
"Stefano Garzarella, sgarzarella, 20"
"Dr. David Alan Gilbert, dagrh, 20"
"Alexander Bulekov, a1xndr, 20"
"Greg Kurz, gkurz, 20"
"Laurent Vivier, lvivier, 20"
"Klaus Jensen, birkelund, 20"
"Hanna Czenczek, hreitz, 20"
"Stefan Weil, stweil, 20"
"Vladimir Sementsov-Ogievskiy, vsementsov, 20"
"Mark Cave-Ayland, mcayland, 20"
"Jason Wang, jasowang, 20"
"Gerd Hoffmann, kraxel, 20"
"Joaquin de Andres, xcancerberox, 20"
"Paul Zimmerman, pauldzim, 20"
"Warner Losh, bsdimp, 20"
"Eduardo Habkost, ehabkost, 20"
"Ani Sinha, anisinha, 20"
"Lars D, lars.dunemark, 20"
"Daniel Henrique Barboza, danielhb, 20"
"Christian Borntraeger, cborntra, 20"
"Alexander Graf, agraf, 20"
"Fam Zheng, famzheng, 20"
"Igor Mammedov, imammedo, 20"
"C=C3=A9dric Le Goater, legoater, 20"
"Michael Tokarev, mjt0k, 40"
"Marc-Andr=C3=A9 Lureau, marcandre.lureau-rh, 20"
"Alistair Francis, alistair23, 20"
"Emilio Cota, cota_, 20"
"David Woodhouse, dwmw2, 20"
"Eldon, eldondev, 40"
"Bastian Koppelmann, kbastian-qemu, 20"
"C=C3=A9dric Le Goater, clegoate, 20"
"David Hildenbrand, davidhildenbrand, 20"
"Bin Meng, lbmeng, 20"
"Stefan Berger, stefanberger, 20"
"Alex Williamson, alex.williamson, 20"
"Eric Blake, ebblake, 20"
"Juan Quintela, juan.quintela, 20"
"MST, mstredhat, 20"
"Christian Schoenebeck, schoenebeck, 20"
"npiggin, npiggin, 20"
"Kostiantyn Kostiuk, kostyanf14, 20"
"Kevin Wolf, kmwolf, 30"
"Aihua Liang, aliang1, 20"
"Helge Deller, hdeller, 20"
"Fabiano Rosas, farosas, 20"
"Gustavo Romero, gusbromero, 20"
"Peter Krempa (work), pkrempa, 20"
"Harsh Prateek Bora, harshpb, 30"
"Jim MacArthur, jmacarthur, 20"
"Manos Pitsidianakis, epilys, 20"
"Brian Cain, brian-cain, 20"
"Anthony Roberts, anthony-linaro, 20"
"Pierrick Bouvier, pierrick.bouvier, 20"

>
>  * No one is formally responsible for GitLab issue triage. We have
>    had Thomas do it in the past periodically with script assistance.
>    We have Alex doing some of it now with bot assistance. The danger
>    is security disclosures get ignored as "somebody else's problem"
>    no one has accountability.
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

