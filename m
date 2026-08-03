Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460C0C55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 21:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqzye-00085n-9g; Mon, 03 Aug 2026 17:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wqzyc-00085E-2H
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 17:13:38 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wqzya-0002c9-MP
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 17:13:37 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-51c5382806fso36916071cf.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 14:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785791615; cv=none;
 d=google.com; s=arc-20260327;
 b=XrXW2F1jmhCKTNnD4O8zB28p0ANLYfHN8EmOOCqA+ElIfX61C9X6I1FnFEVEo7Ft9V
 a7WHauLhiTggX5SshFCXFYyIT0QD0ZcvqgcQ5777M3qLslKKEs5lEBoQm2gPyg4pdmEu
 yLRpVgmcOJ4Xo+Almd3GofgMeAQhfGfJq/Zo7tkii5D9LRg9N0cAVhLIauc8JrWYxThA
 RuQvWt2ehzY1Ou4NzVIv1sfowLdamEA0Bq/OQ/ohEY19KR0dOCNaAurXr4bSZVlmZkyb
 IBqNg1Rqao4UIC6lk/nUgfLaJZP+xGc2ZH5uNOqqnsnmGmRGgEE3Dbg4F2Lp2sM1CvVb
 x1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hT+cJbgNjyBy4vcwWTIgV40hxtVdgcRtIAyv/2vkSGQ=;
 fh=azakwI4Xb9f6DnAcztET+ugSHXzSSw4voANLU4fk32Q=;
 b=VbSxfDK8VAJ8Yo0kx/xy/hrWHHdighlXBMVbV1zBhaSH3sl9xOA4Y4bWEqaiFtLyOD
 kwaXI4tad2ovT2kJg20Q2PEvXTPHrqBgucOI3Va72tur8fjZDizzM8BTg2mzfkUk5oZE
 B+VkadN612bKF2qmF4MQnS7BG+nLzMO9GjpjResxhIxGbg17N2QZtHm3bthDovhqm7xE
 0bsQ5CNB/jvmrY0zqGUcD2qDHsqs2PGqK/+X+626yPPjXjIAVeoKKLCDCGo40CETLIuG
 jFMJc6w2+RWPkAztInztDkW05rC0T243Q3ORGcuCyNvqCreqjO2kAy3f9bnEvgNk/a20
 axKw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785791615; x=1786396415; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hT+cJbgNjyBy4vcwWTIgV40hxtVdgcRtIAyv/2vkSGQ=;
 b=Vj65TGqajjX++fC7Tb0AGAoxE9SsfCsA6wLHyg67s0NiluByv3NcDxPmwHmgprXZb6
 7yRcekJ4STUnwIrXx/ory00IW1uc7Zuv2qOcxIhum8msgwudwHkyqUhuotID7nFf28EF
 xgKd+AeK9d/iHf69qzDMl7l92FRAdcOD0K1yBiU3n4p9vipNjlsk29+YpOaux7yFQVoC
 TuQ7wzx0n4SqDJg/alVtygTlzydgI3aF4wVzDXfSMWt46FCqQEi1vc3e27ua6//6u+P2
 hUUsr5861dDA6w5PXWSXnfIyEHuhIyyNAWlp+NOoIcMMpiMLmjYQj4WGJAdFBcrUbCkI
 ea1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785791615; x=1786396415;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hT+cJbgNjyBy4vcwWTIgV40hxtVdgcRtIAyv/2vkSGQ=;
 b=T1Bsm+VWM0N2XCmbmTM+6oHNu4rGm9i8bcfdMo1k5Xof5TWqYPoCaHSbMUZOz5lynZ
 FKTW1Xwm9iGJfcFT9IqYetlCZWcCPZrBiotQjMVfli6T4/tTmw2qOXgcVq3DxvOygswY
 FdMAkpbmeHuuxkzaKRQ7PYJFuLpRheSsyP5sX1zhIW5TWpEjp28Nbg5wU6yyjc5CxXvk
 aj6ZGZ2++ilj2zv/GDc6bEMyGcct0lwGzF+rFmSR29XV2mojk6IQWeFI3K17s+f2adfH
 U1FCCRmG1BBjZPVK89YyJWE7f+Db5BsgFlf6Q40FZcpTdd4TKmWMPK23GX8w/Z3/VRs4
 yJEA==
X-Gm-Message-State: AOJu0YzxM3TmdBEKuBI+d6VEbFnKj98phYI1fnP+RTmbQxkaOk3poVhH
 2GC4R7kbnv6Bki5vTt7RF2pc/E3BNWyTprBw0eDft0+gOs4WGTZZF+sNnjzTfYEDSnHM23FcX1a
 Uvr7AmuXOQxw/jaQ1PXF8YSMr9cyoy3k=
X-Gm-Gg: AR+sD12OZnmKmEwG6OD/gA0bdYtYystRp9Pb5mKU8KJaGugXi+poKiDKIMz/aNQNHKr
 jLri+blBUox92I3bwDwAnPveLrc1s8UoiqPEvy4Iz8gp7hJHihn/2IYx47tsghmFc3GYNQ3SNhq
 tKVfRe+2gHLlqU49vT66XJWrqdUeVO/Nf84k2txXfeaw68cCsaLkWJmjj9TbltT+8RzA+DHQrfA
 fsoUjczdEWSOkj9wsh4PQmNupCWW/Qd1fK362mteQowE1paGI6QD2rUvdhCu3wQlKd3NCETXOnV
 4u4DHcbBH2WImOHT28eEtyAH6aeR0Kc8MRBTQKbhxbNHc99xIQlzJ9PDtuEzSLNnWYUQbA/NHkK
 a
X-Received: by 2002:ac8:5c8f:0:b0:51c:2190:3b47 with SMTP id
 d75a77b69052e-52b5666c7d8mr246614041cf.2.1785791615528; Mon, 03 Aug 2026
 14:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-6-6b97c439eb28@gmail.com>
 <f7776822-106c-47d0-ada9-fab75f68c76d@redhat.com>
In-Reply-To: <f7776822-106c-47d0-ada9-fab75f68c76d@redhat.com>
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 3 Aug 2026 14:13:24 -0700
X-Gm-Features: AUfX_mxjrOT6EN9f6nOZy_M_lmCwvv6GQNTDcDJCJ16qrlFbkhRfh-vc1CvT5tQ
Message-ID: <CA+spn3rjAu5EcWBwG4NJmwqobdggJmZYVPrvn5Yq58Zyf0NEDA@mail.gmail.com>
Subject: Re: [PATCH RFC 06/15] util/iova-tree: g_tree_foreach wrapper
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Aug 3, 2026 at 5:36=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> w=
rote:
>
>
> Can you document roughly what the function looks like? Because the type
> (`GTraverseFunc`) is not defined in qemu. I know it has a boolean as a
> return type, and that one argument of it is going to be `gpointer data`,
> but surely it will also take a tree element.
>
> Hanna

I have updated the comment to describe the usage of GTraverseFunc as
below:

/**
* iova_tree_foreach:
*
* @tree: the iova tree to traverse
* @func: the function called at every node. A true return value ends traver=
sal.
*              Arguments:
*                  gpointer key: key of current node
*                  gpointer value: value of current node
*                  gpointer data: data passed in at g_tree_foreach call
*              Return: gboolean
* @data: an argument passed to func
*
* Wrapper to call g_tree_foreach on the underlying g_tree. g_tree_foreach w=
ill
* traverse through every node of the tree, barring an early return. At each
* node, g_tree_foreach calls func with pointers to the node key, node value=
,
* and a pointer to data passed in by the caller.
*
* Return: None
*/

