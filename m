Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26552FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 05:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHxZn-00045A-Qt; Wed, 29 Apr 2026 01:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wHxZk-000446-1r
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 01:35:10 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wHxZh-0008Rn-H9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 01:35:07 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6563f83ae9fso6556080d50.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 22:35:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777440901; cv=none;
 d=google.com; s=arc-20240605;
 b=MA6ip/4Q/uWpcA9P1Vx0W76J8Jlrrlpo1p8O6v/GnoNL/bTxAINy2qGZ9L5B8UUhBm
 ZWdnfRM5y9UO92/54vRgdhRBO3nsXAtSGzUZDpH1iaN8k00bRE0DZBHuu7KdCDSsxzKM
 cE1Crwi3zHc47sF8KMqC4ucZSfj6X4EtAwzt3XjHad8QvPfwueiL5P+aXZetYKqHZycC
 6bwkx85Ebo2M7oA2D+FXuJwJHDIKA1NlnuRIM1uPut6ZFULIUxD3xy4ekkAJsHf07Cmy
 JgloXdH9+ECSPQ2LR+BSGQM1itlV3olDtbuMG/6Edvp55myhkpoP33UioRCbyBYWqKe3
 VNJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=p0NKE8Vn5tc5A1Tl5ZRm+yn2kT4FSU4qzhBrwrwtFc8=;
 fh=2vCTedxg5r0JPg5LnC8s7len6poc60rIFIIE/ngH4cY=;
 b=FJlhw3tlLN+17j3vexCfqKDJcIZVDokK/Ooki2+VUaCpIMfkcfsR6Ygxz/lceu6oM8
 atU3HyzMzPm/TzHcetNk+95qCqSYydoXLM0+/8SvHkkGeHU58aMQfdhxsHmwrDu/27VE
 lnR12al/3S0dxvCUZd+uZOMlRHJNFiEZIQNtT+TZwvTq00rVudjhD9dHXlcfAHpAKMNm
 YIVBBw1raeXkQYOsIyKlju4JNqGUygbBv3S4379u7ldWZdDsEhyYBuYIbfHtQwKriK3m
 dxa+BR0Uft+02hrHRxwnjiJtqQKTzdNPE3hylp8sWDbD37vhZ/CMl+b0rrbd1fOM/LZD
 Aq7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777440901; x=1778045701; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0NKE8Vn5tc5A1Tl5ZRm+yn2kT4FSU4qzhBrwrwtFc8=;
 b=aJ6v+ovpoCG/VtphX1LDD15J3EzugUGXNie06oMVW09fMVilexLhX3kRMQYKH6MY/0
 SMYvstRgVMFVd83ojtUEuMF8SKKCWeRKHY46wLvCzZc7/l9XPiWTKwUgPWs1Zd7KhKAb
 Ikb5yFPKf7gVwHVzRLyVbT72hlmQhkzI7KZrc++Vu2RKBXIohEthyUEMuT6npLLc5yfJ
 fIbx6KllDNy8g/KWiAJnT0QAdJTgwyleYMtTCw9Ept8Dea6ZIDu+Dieo5gzOworrhoFk
 63gV0P7ht2VfGQhd3nrOsC1hGnb7FS0iMXJ5MI1yx5bpbrqaNrwpTWtaQrkHm5owLcNU
 Djhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777440901; x=1778045701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p0NKE8Vn5tc5A1Tl5ZRm+yn2kT4FSU4qzhBrwrwtFc8=;
 b=YKlYLQNpD8qbg1WRQUmJrhjJGjR0NJyzBsqd1gQa36UK1qLkpknze5bmY4xoDFNm7a
 nU3PTjxcJ0QvGGTSN4dps+/czXIdLVd7Ldl0vVNKq5GZfMVQ/vna4P4/TdOfp0VeUpib
 BldoRb1oMEE/M3oA1VapsLomYyypJhqr/Chss2i7t/B8n+dIikst00PehTgX2Ccn0bAA
 HA8EJHJHv1IaPc0H9Or4jleBAP+gt3DvQXHjHixGbFbNl0IMUL+4Xrqep4hrMSy1Pitx
 uIhgdyzFNK91zfyUqt3QQ25lH/5+nAbTx+4Wo/MXYsVwU4l+zZCPhWUwvaMXFtB4O9jx
 GSVA==
X-Gm-Message-State: AOJu0YwXwWxrfxU81Bm28oOv0p2s4ad2JC7fGkCIPyiiW/kc3Vyi84MR
 btvVHDMU7rHl5q93MXyjYMz/b/5VAZ1z01Pogl6+6d6R8J6fBficxPcWmyJ4Ff/bWkaU129xSgZ
 3CVUhs0HhoLCRoFSkF3PWQHKN8a5NPhA=
X-Gm-Gg: AeBDiesRsIWtClZdLw37pwvsFPIUnpsyNwsQi4sAFrcfOmGhdOeYlWXgLqEshNTMS/D
 aG3rHfm1WD2BiMcCSRT58LgKYaEMHWCyusW8R1Pkb279/wqq3oNujwn9CL+053tWQp40lTNddys
 69vq4WtvsyLCQW2bazC3wNqQ2FKYkZExNnuy6YdEnHYAvL1mw55FV+jJr1TmaqsYTGuTiVdmO2w
 X6EtSyjiNJ5BTpsGX5iPCJ49oPptGrDKSwh/6pHFKPhYM9WgbsnMRNMehbJs1VjolqZfDOM77+f
 aO1Y2urBbMZARcDLT0Y=
X-Received: by 2002:a05:690e:4399:b0:650:1ac4:65ea with SMTP id
 956f58d0204a3-65beeda783cmr4493368d50.22.1777440901378; Tue, 28 Apr 2026
 22:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260410150457.85190-1-zhangckid@gmail.com>
 <20260410150457.85190-7-zhangckid@gmail.com>
 <87ldedongv.fsf@pond.sub.org>
 <CAK3tnvLHHXoEVngnyUbeTeVdj3w997wSc6heOPJG6-aWmzNazg@mail.gmail.com>
 <877bpr5ywi.fsf@pond.sub.org>
In-Reply-To: <877bpr5ywi.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 29 Apr 2026 13:34:22 +0800
X-Gm-Features: AVHnY4LZsp1R5sDh1Iio6i7Bm_AY1f6UU4uDvHr25gH9iUQgx05HugsrNS1qd7A
Message-ID: <CAK3tnvKh39qJe11OgXrP91fNEY1-fZV9SvC-Pcf2iM6RrzC74g@mail.gmail.com>
Subject: Re: [PATCH V6 06/14] monitor: Update tracking iothread users with
 holder name
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=zhangckid@gmail.com; helo=mail-yx1-xb12f.google.com
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

On Tue, Apr 28, 2026 at 3:26=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > On Thu, Apr 23, 2026 at 8:44=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com> wrote:
> >> Oh.
> >>
> >> PATCH 02 defines QAPI type IoThreadHolder as a union with two branches
> >> for the two kinds of holders: one for block node holder, and one for Q=
OM
> >> object holder.  Both branches use a string to identify the holder.
> >>
> >> The C code in PATCH 02 uses just a string to identify the holder.  Thi=
s
> >> silently assumes that the strings for block nodes are distinct from th=
e
> >> strings for QOM objects.  True as long as we only use absolute QOM
> >> paths: these start with '/', and block nodes can't.
> >>
> >> This patch shows me there's actually a third kind: monitor.  You use t=
he
> >> QOM object branch for it.  That's confusing; a monitor is not a QOM
> >> object.  Moreover, you make yet another silent assumption: absolute QO=
M
> >> paths do not start with "/monitor/".
> >>
> >> This is too much for me.
> >>
> >> Please use a separate IoThreadHolderKind value and IoThreadHolder bran=
ch
> >> for each kind of holder.  The kinds I've seen so far are block-node, Q=
OM
> >> object, monitor.
> >>
> >> If Daniel Berrang=C3=A9's "[PATCH RFC 00/17] monitor: turn QMP and HMP=
 into
> >> QOM objects" gets merged, kind monitor can go away.
> >>
> >> Use of just a string to identify the holder requires strings for
> >> different kinds to be distinct.  The argument why they are must be
> >> written down, simple, and likely to remain true.
> >>
> >> But I'd prefer to use IoThreadHolder instead of string.  No assumption=
s
> >> necessary then.
> >>
> >> If this IoThreadHolder arguments make the calls ugly or overly verbose=
,
> >> consider thin wrappers for each kind, i.e.
> >>
> >>     new_ctx =3D iothread_get_aio_context_block(iothread, bs);
> >>
> >> instead of
> >>
> >>     holder_name =3D bdrv_get_node_name(bs);
> >>     new_ctx =3D iothread_get_aio_context(iothread, holder_name);
> >>
> >> and so forth.
> >>
> >> Questions?
> >
> > Thank you for the detailed explanation.
> > You are right, in this patch I silent assumption: absolute QOM paths
> > do not start with "/monitor/".
> > Because the Daniel Berrang=C3=A9's RFC patch and the monitor implementa=
tion
> > is very special,
> > it creates the iothread for itself. The iothread lifecycle is same
> > with the monitor.
> > It is not a general case like QOM and block node.
> > Maybe no need for this case add a third kind here?
>
> I don't know.  Or maybe I don't understand the question.
>

If no other comments I will keep the assumption in the next version.
At the same time, I will try to keep looking at Daniel Berrang=C3=A9's RFC =
patch
about monitor QOM.

Thanks
Chen

