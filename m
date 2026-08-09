Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70227C5AD2C
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 00:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsrXE-0003Y7-JB; Sat, 08 Aug 2026 20:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wsrXC-0003Xp-TX
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 20:37:02 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wsrXB-0002rA-I0
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 20:37:02 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-51c2b2c9eccso4763621cf.2
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 17:37:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786235820; cv=none;
 d=google.com; s=arc-20260327;
 b=OXAU9gNUq0r37nd+96cae3fIT29Z2VSVTXuyzp7NcXURTwzaj9z66olRZzWxb6MGHp
 pkRzC3ONkPL9p4E7YxgpbHKMkZP+7SXZ7u9rwnkkwCozYE9fmjxTOnWa2X54JhamyIJA
 gFpFGHt77VAGUhn7rOwEcbTur21Ra0+e4dxmoDf3txjcsFN1Id2kDdHXG8ET6n0a2ryi
 1f5bGSbsm8PxffTICwqaHJ+blMon4VtCRTVDSo9hfNLyIi+qDfBl+feqmMQlEuSe9Ere
 xKwPToSzEOMpfffvuv8u3Y47nXadTEok6ZLrjUOb4sHwfs6DSFKAZD/fXPa/smtk0zNB
 9MYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U2FNMfCeaIJSY3FbDIFWzwdejgvJPNQmwpErCpjxCc0=;
 fh=azakwI4Xb9f6DnAcztET+ugSHXzSSw4voANLU4fk32Q=;
 b=piZmr6OEITBRAXbLsQ9yDjKsgzXEQ1zIui/5BrhRAh58lJvJb/XJ/MWBH2HYy9Da4g
 pyBzG7SiTAI3Jx0rNBrHi3NVBazHPV+enjzViHfYnRZiyov1O9I31vbptlfMpVZ5phfR
 DtPT7NVszs0+lESKFg6tb0mNDDhrRWoBGFRBuZQvqQcTQechwMFVesQBbg/8jCsRRaPS
 0tanUOOz0b/4ua4UxFSpCf88MAE+4QYhB5t4NjtiNcX28+a76JlKaS+/KkFznzDuytiS
 kaEcaVYHClTx1hy88e+RK5xR9Z8t37gCti6UYzLGbLKyB0zNk48umU5JGv/pf8txLbGL
 xkZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786235820; x=1786840620; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U2FNMfCeaIJSY3FbDIFWzwdejgvJPNQmwpErCpjxCc0=;
 b=qeoeZPwJejlqIsMRX9d0d+lt+X0mefsLQhALCr3lKjiXdZRT6w9eZIVM8ATjGrGZWW
 2w9GQEvxkvHMkqojzlF2hAeE/3Jsf0JqPMvjH1axjB04qP296mMqjb+S8wmtNV6Eu00G
 /Pp5famtc2uI9f6N2uNV8aFFDdsn8V+mtjPeoDbuITAcLz2Nhm0wABwaZ4x7bg4pLqMh
 Njn0T4PSwAzjtaxRvbk7pqI7g3EOLDi2RIiRc/NeZUhSmGESxu2F7igliAEhhAQLeEZq
 z6F2Z5AXnfV4DiUGZvqOKEA9MUAREiQ724ds/iR0xVsbq3ARZPv5Cd1jjocLzYPvfAwn
 enCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786235820; x=1786840620;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U2FNMfCeaIJSY3FbDIFWzwdejgvJPNQmwpErCpjxCc0=;
 b=cMr57LvpInDDp4WdOyaAFDA4rgAHc6PUcL+wVK5O2A1/sWw2hWbBk7/TsfbNfwLAgE
 39tkzrazs0V1/8KJC9uUigiRJgFh3bCMFpLkA6loheMnyyZsRMbrU7Vf1xMw1nOwrzXo
 gLB0Xz51ukCQntO3R6RbocCDmTeKnngl6+aMD5Laz1DFn5aNXgxMQKBAo9QFPv5cyF66
 bVCz+v90enFuBeWNMMW3zM9U0BVgvQxQ77xgvBgaP1KNadW+kT4Uv9vPzr6301dsvDyP
 tRWMVo8K2B7HoUF01B+WF+A4ppdCW1qwr1d4kqZE0xI/iD/OklxfTeDb3rlgaqj8CVp1
 dHmQ==
X-Gm-Message-State: AOJu0YxTPadEANjMepLoArDtDG+/IzwvdJArbFvUgOwDS8Qq80XBSd0s
 AwnNoiU5CUNcpPr3VMoJUrDIc3pBGbe9cM3lTYQjbO7FQ+3T/EN1bcbQ6+BBgSvR2d5cMqwrkbT
 6VRhFME5j5LvNT/Y7315fyIUYj8JtJ9Y=
X-Gm-Gg: AR+sD11IJTy3LdwKAojDdQhwChwRrKE9kTSYuObF2DiRAtJ0k4iOpzn21YOcHzHJnsR
 JYZZww0yHIdenn7iyv8pho/tyVmpaabphbr8V3UtMN2XbZ93Scof9kwvDPm59lSGbgUsoKjzK7x
 j8UYhZgbEKrGVg0FIvtMg7iRqP6O0w3GI6EeFfhjN4LkQ3Pxz8471mwh6ocfO9FrebxYZ3EdTSg
 8Ju187POryAbD24x1iugN0Gg2JmgARVJGC3vwFpjVNNbe0IFYRTdHSEPfyhLNm4IbzvMww3B+Vl
 D8O1DKA7a9zYTCHmcgpSMsidPxioRGiuPCByP7SyzBi0Med4p9tHnbrBvfATyYGceUn2EC0B/Ca
 zHp5+ANAWmT7AZQ==
X-Received: by 2002:ac8:7fd1:0:b0:52b:4c5a:5844 with SMTP id
 d75a77b69052e-52ce6107865mr337663041cf.20.1786235819757; Sat, 08 Aug 2026
 17:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-11-6b97c439eb28@gmail.com>
 <b6bc052c-1bf5-449b-85d0-e1c4624a5d99@redhat.com>
 <CA+spn3r9X4WST1c4LYS63xN0EFogkD1dJ6P4omk7ndMDeF9D5Q@mail.gmail.com>
 <fa4a6c1a-6b21-47b7-8d1d-25b71cd70a8e@redhat.com>
In-Reply-To: <fa4a6c1a-6b21-47b7-8d1d-25b71cd70a8e@redhat.com>
From: Connor Kite <connorkite@gmail.com>
Date: Sat, 8 Aug 2026 17:36:47 -0700
X-Gm-Features: AUfX_myUuB4bkE-RAsE8iU-1mb_0CTwrRXRqflL9p9Ur6l0u7MEkNwMV10ZQaUc
Message-ID: <CA+spn3o8FRxRK6q8SAyXxjNhRBdCt7m3Si3hqD5JZ9WpVf+FWQ@mail.gmail.com>
Subject: Re: [PATCH RFC 11/15] hw/virtio/vhost-user: create isolation region
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x835.google.com
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

On Tue, Aug 4, 2026 at 4:03=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> w=
rote:
>
> >
> > I guess the alternative would be to have an `isolation_mode_ctx`
> > type of struct to hold all of the above.
>
> Yes, that=E2=80=99s what I thought, to have an object that would hold eve=
rything
> that is used by the isolation code (and rather specific to the isolation
> code).
>

You got it!  A struct to hold all context specific to isolation mode
will be in the next rev.

...

>
> I mean, in this case, I would have just used a plain C array because the
> size is pre-determined by `nregions`, right.
>
> In general, *I* have not used GArray yet (no particular reason), which
> is why I had not come in contact with the `&g_array_index()` pattern
> yet, which had me stare in disbelief at first. (My main problem being
> that the name `g_array_index` is written in lowercase and thus indicates
> being a normal function, whereas macros in C are generally written in
> uppercase to allow at-a-glance distinction. So it pretends to be a
> normal function, but glib recommends a pattern of use
> (`&g_array_index()`) that would never work with a normal function, and
> that I find a dreadful decision by glib.)
>
> Hanna
>

g_array ugliness is now avoided by using g_new0 with nregions to allocate
the memory.

