Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0526DC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 23:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrlGf-0002mr-06; Wed, 05 Aug 2026 19:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wrlGd-0002mR-5f
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 19:43:23 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wrlGb-0005W9-RW
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 19:43:22 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-517dc520840so11171421cf.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 16:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785973400; cv=none;
 d=google.com; s=arc-20260327;
 b=dxM9fpmFaZCTHszmrLYjG3/M4P/ptSyRUj2pi+U9sjqR4fe25FCJcLpeT9ri0H3ZWf
 F8cQeRl6s499ZhL+gsLBhANfhdqFkEA+jtXeimjwalqzFuElUCTSIT4XAvRe9cnAVsPr
 zpXmw2GvgB6IJoS1RWVTvKhkbCixnB00+d5S5CD7y6kesQgNWhTPjfSyuzHmAPVMPjA4
 tQxpGKIkZTN+FFL2Qan18ILnpqDIMpCvUJzggoZaDycydACJgXZFZ+uz+mWfjCVxcIfH
 v2eEq8eOYYddng5gV/6Z/PID3XMDqTxyDMRo+GUA6xp2bfB7Tq9I5FXKfGmPAKvJ2V70
 HjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xIJW997ztiLIhHGWA4IExsY472xyxS4LNfDtfQost7I=;
 fh=azakwI4Xb9f6DnAcztET+ugSHXzSSw4voANLU4fk32Q=;
 b=dPhFiGoKS+odhbV6a5HpH3vC2H1fOHVC31DM8AAER1UUP7RzRAk+i6BDdhvFdqpjkj
 6jHFP9eVyE3iASpfcAfoVU5yA7+4stZgNJZ0Oe2V+OLXuh9lEhiXKt8W2DQEIc3AFbuO
 J8EisZsJjvP0pyD3g6YhVt9SS735NyFwEoZSiwGc46D6vIaulz/itXSz03S56V96vbDI
 RsE+aPW7u7Fk4PUnpEkYY6JRq0Tl7nSO3rIruBwK6kHnwsn6WRBJ0jQpf29nzD/GgtHl
 W27KvVUogOa39cP51v9TXOU574KFTuz6l7yRDlxEZUEe2yDjmdj8KjtQlWF+0KZZF9zH
 akPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785973400; x=1786578200; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xIJW997ztiLIhHGWA4IExsY472xyxS4LNfDtfQost7I=;
 b=JmfdaNyJXIRoqg/UfZhCNwChHt5+/dNu+EULp+TYWgergGSPNd7JrOJspYiog1tZCQ
 MycS9bZtv6GG113u0CB7t8SFVtga/KkYXU2YDdAkYVDy71WuaxcJCO6oSnzTMrKa3IjA
 rP5pa2hAGM0wXyd3k+Q0AAUKn9DScHOuHYN2fsBNU+jLrswdW0Q6YL1tNct1KdmetpjT
 sLS4QSEYxWq9pPed8O3Fu9fhComzvjNNFd8Ei8/mlc5N1W/1sy3GT9RkNSMuLJcCdhJv
 8mTpnmHjDoWt4RJdbXAewPzjtw7DFsXm4cSSwjLLsPRCVuuPt7TDRMwl7HBIsZsb3IEa
 huMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785973400; x=1786578200;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xIJW997ztiLIhHGWA4IExsY472xyxS4LNfDtfQost7I=;
 b=XKsDYSNxsNOxBLnq/o6bgTWWB2jOjU8k8iJroMCsfWtaRD7qOVyWaJ37Gk5KFTSycw
 A6Y7OVBwYX+9Rom2l+40Ex2lKBZLUJA98hUfPoFpTNoTxab8/jp4hYsscspt+Co4J8H9
 QiSfn4nZG0AgDa6ryRtnGIntO2sxdptHLcWmTjneX0wA/NVGxWEWf1ECXV7lGV/rC9tf
 /tZFh8IxDjP5sXvjuxdzXQoPQdAjduZhS6XE2KXCqyGzu85IwlqkN4py4dbDVWZZ/avb
 XxlGcqptQoGIeJEa9tgZYXRD4WkXhs2/bjbrFQDbNMapvnWmWiMyjzvZRqnDlI9QUUOr
 T9eg==
X-Gm-Message-State: AOJu0YxOiEMZiy+oZEjxFUZDuM/XattiTK0puXE3aaSxYO7FRpHTO+i9
 4Zjlx6qcZfvuXKeeYJlvU4MSQGPgZgB4xVGNg24wwjB7RniUbeLbdlCO+7NEaw+InTBc/0XN0tK
 9FM8uvh5izwHPWSXtepyAlW/E7Dxu8GU=
X-Gm-Gg: AR+sD10qpQR5LU1aTCneuwDJFO267gXZZRp5+RQQloT/0r+l5pEdk718KwqW1pk9i6S
 r+VVS1iJ2Tub7cYmx+fj2oPAELH1OsGSUwY5VKRK5jsjJF2PkzD2/FTzxJpjxH2fVkGIiok/neJ
 gxLAhOwO0HNnPiZVOezwa1YUHqgH+pMDBAhg95skvTPddpBTcjOP1NPymSQDy+EtkuohJvnLmRb
 BwrYj9AhQQlIdGGyFRq8c2a1J33DO9IbaEewi40e5lacqTxOVC2torRD99sYMsqD0Dm3IX0c5mD
 ejdRLuLfapZDqcx0JUqbtBFDf14pmUHQ0QFXidk4NJhj/uSEEqdeW34h10D85NWr3OgMBxU3dxL
 AEl8=
X-Received: by 2002:ac8:5a91:0:b0:51c:1ff:2512 with SMTP id
 d75a77b69052e-52ce61a411cmr105675181cf.33.1785973400069; Wed, 05 Aug 2026
 16:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-4-6b97c439eb28@gmail.com>
 <6f915ae4-f9b7-4e27-9c3a-3a99917b499f@redhat.com>
In-Reply-To: <6f915ae4-f9b7-4e27-9c3a-3a99917b499f@redhat.com>
From: Connor Kite <connorkite@gmail.com>
Date: Wed, 5 Aug 2026 16:43:08 -0700
X-Gm-Features: AUfX_mxPQyAbn0_F9JssL-jejkCyVtJEtgg98Zlrxpmii0NR7zZ1YyRDcPcZAPA
Message-ID: <CA+spn3oXmgk7_LMP+hZRDPRTQX8qm0uBGAyztsq+Yu4_d4_ZKg@mail.gmail.com>
Subject: Re: [PATCH RFC 04/15] net/vhost-user: add memory isolation
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x833.google.com
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

On Mon, Jul 27, 2026 at 11:48=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
>
> This is dead code (hence G_GNUC_UNUSED) and is harder to review because
> we don't know how it will be used until later in the patch series. I
> guess vhost_user_init() and net_passt_vhost_user_init() will gain a
> memory_isolation argument in a future patch.
>
> Linear reviews of the patch series are easiest for reviewers. Please
> reorder this so that vhost_user_init() and net_pass_vhost_user_init()
> are changed first. You can hardcode the argument to false in those
> patches. This patch can be moved afterwards so that memory_isolation is
> never dead code.

Now fixed for the next rev.  This and the previous patch are swapped,
with hardcoded values of memory_isolation used until the property is added
to net.json.

On Mon, Aug 3, 2026 at 5:27=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> w=
rote:
>
>
> I have a gut feeling there ought to be a better way to add an option the
> only works for vhost-user, but maybe not. I certainly don=E2=80=99t have =
a
> constructive suggestions. :)
>
> (Apart from that, my only comments would be the QAPI =E2=80=9Csince=E2=80=
=9D field
> missing, as Markus noted on the previous patch, and the patch ordering
> Stefan has noted.)
>
> Hanna
>

Added "Since 11.2" to both locations in net.json.

