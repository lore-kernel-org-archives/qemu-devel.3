Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3314C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 01:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwrUn-0007cD-4q; Wed, 19 Aug 2026 21:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwrUl-0007ZU-S9
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 21:23:03 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwrUk-0007J8-6c
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 21:23:03 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-934956bee57so177534885a.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 18:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787188981; cv=none;
 d=google.com; s=arc-20260327;
 b=kyQcjN5wcSA+rUg5jdicy5Zz+2gNbcTmBUHtbK3PWTxP0Mk2bOgaZgqlx0dpsfn5oh
 jzkePxWLYwwgblCfMvh7+AfcNza7l5Gav9Nl+x2avZdGIlM2+ehOsIu5Da+5Vgkwf2ez
 GrOEeUcAJQpkZ5lNuWsz/hjGhr8N2eHZLWp/+Apoc484rhEkLx3wpfoYl0cx1hwwK4r+
 IUi2jcb1LxFGGTc8piPazehtNEpv9G8lDetfbrLeTxvwaUQw0msYZMJrNitTrV3Zcz9o
 lR4vMAZArWE+6gOpYNke98F/1Ut5OzV/rmAOrP+spUlboZkt5ciybTDYi4+H/38AeK5H
 LXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fEPJshVvRAljzQG147X6Ty6PBl0uhRhyX5+dH7xacrU=;
 fh=zAf9Wul48xkTrIs6bAeEfpaQhknOU2iSq1CvwgfZtyM=;
 b=cmUrb4965Kp9LwCsU60e/YdLRzBuLGLwEx6UoZfE+mklt1v1kdCuvDfU5lNGA/+uDv
 y1SAaRMUZg7XmWHst6U2CIKFcf8VTPDHJW0/Lg47bDpkl7uNv34hLczr1JMprX7a32Qk
 fUEc+pSEwQJIXFaPpSnnvLfLs6kYuLJ4KcetgNT5xZcY+FTk29Wa3RMCFu2E1D8BYxZ5
 ddRZp0xCGoOgeunhnVcPiwO6leJ7G0F1NqExf3FH6Q+Ub8azg2GigI9IZb8U1ja2CXYs
 7cO64+JdJTlcawu6xZB+MXkwSC+slrleDQTxlTwEm/kzymtxnnhUo7uPuWjaaN80KcjR
 Nz1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787188981; x=1787793781; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fEPJshVvRAljzQG147X6Ty6PBl0uhRhyX5+dH7xacrU=;
 b=EozWzTmNpkqrkmtH0wXfEC0jSoXBKz9828nDJ9zktxfaC+LVSNQLfECIeM9DaSLiTe
 hDSnqovqrr5QH6o7CzaWYBCvB1trWRPmHSpRMWWwZG135mEcbpS1j8Rp3oQYe5wufEFn
 6TxoHksfql2IMTS+Gy2lD1XKVVwdI8VqONksAr+vjppftxkGxWjZzwJ7yojczPtkGoy2
 nswFFq0eS74oyeGAHookrg95316VE+Fap9OHkFnljp7UdMU1eYBg1xSCOa5UF5WWZ8GD
 OCaLxijk2JXD1x+L+QfgfNOfwiLNjm6UZ9vpjDe0KTramR2jVCdD7MZRqNyKegknTpmm
 h1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787188981; x=1787793781;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fEPJshVvRAljzQG147X6Ty6PBl0uhRhyX5+dH7xacrU=;
 b=hZ/j/YhBY7w40byDsVrTvOEpXS2jA0NKbgTY5/i4sh4qBIuo4Yc/nkM50I5ULTbD7S
 q1g50AZxROE14LXA+C/6ppaxZjYP+32HuTSr7tST0JXrU1wz3GMMaoIW8MWkjCWnCPVm
 bNdkJwcc3+jESkyI9Og3a83PjHgcg9Fvr5JRRc74GsMyHyiAw86pr9x9uvabLufTgTe0
 ybm+AK75VjuD5zDY05peW0x9H6Z8ElJEN7e4/nm8GCZ0bamrsZHZz/Uv25tTYqFR21pT
 eS6zsmn0VgxD+5FF/IZmD0/SPK8aFX8HBKyX028+tKsYYTYVIUPrH1aRTXwnie3y7NF5
 6TEA==
X-Gm-Message-State: AOJu0YxE4nGORQCa0forwOgpbJPuPnT2YRxHFhE/kxVK7JNNOfM1mpYw
 QokGsPlzaN+WkVgVymd00RsuLqlu//mmbG4N/VqC02E0Av6RGSNE2N6dAk7tXxgoYJ/n3OK4scW
 9it0l/3YY9HzMGqYixuQvtnYHgFC8ow0=
X-Gm-Gg: AR+sD133qrBQG++KeUrDv1By6bRAEPbbvVUG5KxsRP7NoOEzPylOwAup5i/w62zCstW
 knvHqiGR8Vfq2/v9fNmGDCBgjdA9mxsv8CDO++EQLhoupjxHnhnX7XGw9RQDNaiptx+VMOQK1XF
 NVwhIhaE7mND+nP71j+B9Trv0Hxb0BonbIX+43nzrZx4QJ920NEXWuOtwsygpn54Ms/CZBoehjK
 FsKWTOh84xQyMKxQt8/HXj0MQzODiRJCbQqgE9/GTP0jcsxRHJm96u41YWw6KKnSDvFuxWDkoDB
 Xf7gHFAGjThqnih4hnbfFR8So5s7cIQfHNzpYumK+lmH6qm+cRvpmtFBc1R3KA+ylqLkZGdJm0g
 5frI=
X-Received: by 2002:a05:620a:470a:b0:92c:103d:63dd with SMTP id
 af79cd13be357-9371e30d64bmr825382685a.39.1787188981058; Wed, 19 Aug 2026
 18:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-13-948aae960abb@gmail.com>
 <15427c56-a585-48ff-b024-e48a2fdea697@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <15427c56-a585-48ff-b024-e48a2fdea697@rsg.ci.i.u-tokyo.ac.jp>
From: Connor Kite <connorkite@gmail.com>
Date: Wed, 19 Aug 2026 18:22:48 -0700
X-Gm-Features: AcwNN1WYAAFsNg32RpeVzWj-vcYKbWhQ5GN-92FmFalaloYu8x_uy2_lP3Y2MrY
Message-ID: <CA+spn3qZ9psOFGyVR-5=ou8hExDFZg0Yg0TdUxeC91tNKmhCTA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 13/13] net/vhost-user: add memory isolation
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=connorkite@gmail.com; helo=mail-qk1-x72e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Aug 19, 2026 at 12:37=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/08/18 14:12, Connor Kite wrote:
> > Add a memory-isolation property to NetdevPassOptions and
> > NetDevVhostUserOptions in net.json.  This property will
> > be used for vhost-user devices to disable access to guest
> > memory from vhost-user backends.
>
> The cover letter says multiqueue is not supported but the code just
> continues with multiqueue and breaks.
>
> Regards,
> Akihiko Odaki
>
> >

Adding multiqueue support is my main focus for Rev 3!  My testing so
far hasn't included backends with the multiqueue option, but I will
correct that.

Thanks!
Connor

