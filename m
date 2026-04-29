Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FD2FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wICAA-0008QW-KG; Wed, 29 Apr 2026 17:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wIC9w-0008Fv-8w
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:09:33 -0400
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wIC9s-0004La-Mm
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:09:26 -0400
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-12c6df0b9bbso600627c88.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 14:09:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777496961; cv=none;
 d=google.com; s=arc-20240605;
 b=OSZJ1KEEHC636F4yrxedQGgqgAP9tbnGxFewC6juqMPSZWu+iN+HojyQXykSLOcsRW
 NeVpVW2qA8UGr63xdgR6JKit7xP3GvTWvEGJl0CM3FRqYSzUAKTLOx6EZkjX2r2fF/ED
 DQ1VVlduH6FLrqnxVcJVbTSZzMi4iYgK8Z8WmYS6AWid3+6APRzJEoyumkYb+Bu6voh5
 9Obg6OLdLJtFmK3teA9Pzs58WYdiaeC2FEJFtvz6+9B7Mf7gvcPScNAYpmHOVISZ1Jgh
 9hs+FvdgJboOhf3D9MtMEdJ0cnE5TivLw/sr46m/NxtwmSkERKvFzeYD259Vt1oiTfGI
 W2EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PkDaFh8OeoQRT/t5dFy4l+AqCf/D1cAFW6Me/yFXlyA=;
 fh=/iqqur8uyEmPv6exOEPZWtC3vJ0YC3QMgE7D6cx6S6w=;
 b=TdqXiwTAGSQGM880LeD14C6GNi5LCV3mwLIbM+nxXMKnBlGx4DRcGa+FIvulMdgnuf
 cxTc+yuPsA1yAKDW9EsQxK5+O0QmSOkTYE5OQwkFo2qo2lDxXIsucdq9ZN5Rl1j3uBM/
 ao/XzK1zuL0+rdnqU0kNl3E+RosQWmsvlIY1WRA65dTZ0kHlyAxywe0PYv/J0S1IKyqr
 sguscb+WAxt/mAxew5pOzvb/5tEaxUvEdne72i9gW3YD1st4xDRVEV4slzVbx8YX0Srr
 rbPnsN9fhm7XOS6fhi4X0I1SigvMDpEbrNhcafrl5ueakuN4/BT7tFAaYPZTVlTCsAx7
 V/oQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777496961; x=1778101761; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PkDaFh8OeoQRT/t5dFy4l+AqCf/D1cAFW6Me/yFXlyA=;
 b=dO6mQOxOnu3xQHTdNbjY5D4OZlBG1zkRC4O+vPz7TO2Ehx+zbKb+JKGfCR4/ksGpks
 NulIPOxMQNAk1SNtJRMg7zQrDPNStxQerqrzfFOKpp3MATRpCJ+iLXynp+V92W0uqMyb
 igsyk+AsfFREJwPzSv1z6sv8wG/+CiVfax+86uqjRHrWcw3usmTwmJit94rGEIYNpE4e
 0CR+N4rJ7Judz5synegPW4h0zo/RhS/vJ3FhA40qxwBVrsq+70XDcFHZKkG1qDlbmL0t
 3AVLNZ4vfXB9kl1bCFuW4XpWrEEe+Qw3lLl4zLKCEg956ZlFVokGXzNXf+5C3u/B5YgE
 Urqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777496961; x=1778101761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PkDaFh8OeoQRT/t5dFy4l+AqCf/D1cAFW6Me/yFXlyA=;
 b=kHRLCqMwBmQzlivMUluXCsvVOjnZndeWtl2tn/aRIJvwD8UG3tS4MSTP+mlliT9tdM
 /iI1jRxae5wFasMR1dI51v5BOu5IvVUVrElSngVi21Fbg43bvkzIiJOCqQoXXHN6t9wn
 y7yIne1EHw4F4Ke8uX+ZJluBGLymT7n00c1GOvmHMIWIsTHTBsok6lsdT3eVR3u8kutE
 uac23tqWtgUGoeBO36aouIXirWA9rLD4d8pgws3c8cBgTuh2fvS6Stj1jXjjLWFO5/RP
 BzVT7Ktq+vd0nevddgP7STZ4/Ikvrcsjb/nLkLu+J0KtQ4xkWYEv3icm/bStRo/srNT6
 4Anw==
X-Gm-Message-State: AOJu0YwiA+uvVrt0DrOD5xmgWCkzYCr1JYXZlaQWA6SmG0bJFVdwBzm9
 cgZD669uR/AAYHUB0qJvv/Atlc32COX8AoGpcApOOoh9YuOBDKP760Zy23RfoH5tS8Bc9sGMfvi
 YupQor9H9hUfbFX1Il9yord/sXHt7TK0=
X-Gm-Gg: AeBDiesMc7hIUnXN9GiqE2iJf+8Ty7mJ7XeewgaOQ1U54+iiougdRPj74R/JEFjakTZ
 fHJhFXnndlMycqWzvAz4IL8eynjaOS6in45XXTVClUmjgImxNgggHqT8Psh3YnxA1kSobcy62nJ
 GS//mfrAvk/FTa3bDMWkCnMBFDH8jrVPiJZls00l9mWu/jz1G+MsgAL0TkyndxFR0Zw5bxAfTz9
 gcaW/S0i7TTgQz2P+2JAMbsA22aANVPUQ7zx/efK4ExjcDjKrG3w9cWeDagbF/KkXcXWXMdsfFC
 xhTR8KeGvGkpP/Xk71bIz5vHpGFGy9Q6HtC7hLgrVl2z5V6ak0t/tkCIOfnPfQ==
X-Received: by 2002:a05:7300:fd08:b0:2ed:e17:d50b with SMTP id
 5a478bee46e88-2ed0e17d6eemr3773007eec.30.1777496961421; Wed, 29 Apr 2026
 14:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-12-c413f3605311@redhat.com> <afJw9Pz0alpWvRdd@x1.local>
In-Reply-To: <afJw9Pz0alpWvRdd@x1.local>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Apr 2026 01:09:09 +0400
X-Gm-Features: AVHnY4J7eZRZQDUcTSKLFUm4XQc1LGAobg7CKesmuJddlBPMbkSB8zZje_TtiN4
Message-ID: <CAJ+F1CLUKC=m2WmWj+LYk-YUY3687FCEd7ddV9TrmoKfvLN5UA@mail.gmail.com>
Subject: Re: [PATCH 12/41] RFC net/colo-compare: guard finalize against
 uninitialized state
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1230;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dl1-x1230.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Thu, Apr 30, 2026 at 12:59=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Mon, Apr 27, 2026 at 11:42:11PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > colo_compare_finalize() assumes the object was fully set up by
> > colo_compare_complete(), but a bare object_new() followed by
> > object_unref() skips the complete callback entirely.
> >
> > This causes two crashes:
> > - qemu_mutex_destroy on the static event_mtx which was never
> >   initialized (colo_compare_active is false)
> > - qemu_bh_delete(NULL) and iothread dereference when s->iothread
> >   is NULL
> >
> > Guard the event_mtx teardown with colo_compare_active, and the
> > iothread-dependent cleanup with an s->iothread NULL check.
> >
> > This is an alternative to patch "colo-compare: Fix QMP
> > qom-list-properties crashing", sent earlier, hence the RFC.
> >
> > Fixes: 45942b79b9f8 ("net/colo-compare.c: Check that colo-compare is ac=
tive")
> > Cc: peterx@redhat.com
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> For this one, wouldn't the early version be better?
>
> https://lore.kernel.org/all/20260423183212.468047-2-peterx@redhat.com/
>
> It's simpler and skip everything when complete() isn't properly invoked.
> E.g. if there'll be new things added to complete() in the future, we also
> don't need to worry on whether there will be one more null-deref we may
> overlook.
>

Yes, I have mixed feelings. On one hand, I'd rather have clean up code
for each field that doesn't depend on some extra state that can also
change meaning Otoh, I like the simplicity of your earlier patch too.
I'd say take what you prefer, you are the maintainer here :)

