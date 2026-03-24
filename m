Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EF4F54ABF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52Nb-00033u-7H; Tue, 24 Mar 2026 10:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w52Na-00033a-1x
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:05:10 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w52NY-00018C-CN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:05:09 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso372802eec.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 07:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774361106; cv=none;
 d=google.com; s=arc-20240605;
 b=cR+avS5E6k14lDVQHl4ze5V8wAZT7mIfMjH/u37AoaReGqYcbBz4yabkpR0R+Ta5ZF
 QrxdCZQpduZSDyjtZocAbOn3n7hBhVhJZsJRbeRcwdREEdRyn2DmGdaZHOdt+PgtchKt
 h420zfkqhY9/MrEJrX7gtAxWw+r/gnw/I/hkPAJEoTKbCMcr0RdLVLizOHhoQ4/Wx6LB
 syYTaegAPRNrjFPjE/qo8YNTjfvFHfnxthBbKRo9mMUTV1pqp3aejzPN7VTRrCATLK3R
 sH7+tBfQ9bQBTS2WjOVyVzt74E7KdriCQo+ZLxABjn3V0tohgDU5zWVjx7Uczk6BYEoq
 rY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uUZPNBkmyZwhwvb65AxWnk6aQC4RY6qtcyDh8vIyb88=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=Y5puGSkbff+uXODuDt4qSxv/30g9jAN4Pu1QT5OQ9FzKy3LmYy6QfBm6M8yvTxu1KQ
 +zOg5SXxbK9YQqpvQigqb9btsycc6immq5KsWjmqTkkhikGhZ1ttrUQFQS3W05Vi5gRS
 WOVclh7KnyqwHQlpbvPNhDkGMvD+ci1F5YbS/z53oG0lKxZLrw62S7wM+TZEGk22ksMX
 4cFAtJDuAia4SDXJUINMRl1BPPC4UWchIUQurZmVaVVn6gueY47FY0/LBmRy8q0aLWt3
 yVn2lSm8qvJaCEAqbinLMUD3OWnQYYJKQ3zSdy32Zk5LS3tfnb8DLYiYCh4BsXXj1TaU
 rbyw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774361106; x=1774965906; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUZPNBkmyZwhwvb65AxWnk6aQC4RY6qtcyDh8vIyb88=;
 b=hFJ/IyZZRrSFcOhi8hulX+ihxD+6gFShOQaL2S3iSqrtiYWKVgc7cEslde9c9EgZ/y
 R7S0jPvgqlJW/jI+OjQ6SvaMMiRtls6DaHZfT+GC8qP4mvNb0sOfiYz2GByG6aNuf9PX
 4ke9E4Kv/vBZ2aDp3feNV8hAPSdZ+9gHgWeBPsoTSgBpiOu9GPzpZQxsERtq4d+gsPZS
 jhZaXGFinNeUtN+TeROjOUDxhBXtd2yJzGyDrBxF5RgXJ7JBnCUBLdD0n7sPjuRxEwH4
 qcsHK2zPoLrhEtPxMWaf9UCouUiLlxRmfcNgsjeUG6lY+S2U+DkN2EcrZ9S4unAWCibF
 giHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774361106; x=1774965906;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uUZPNBkmyZwhwvb65AxWnk6aQC4RY6qtcyDh8vIyb88=;
 b=OMGchQWQa5C3pfSoXwlKf4+2jNjkEH9twvXT9iBQM1H7W4SHPSQcffmaGUCrPWb6o0
 yWOpAujK3a/rUWIihFoOQLnIBj7w7X7JKQjNpiVvlOR4Qh407BAVCr9Ar3/GDT9dU2ev
 qqF/DGMDixtwa3W/1Mo0cOErc+f1IAnOxHDNTu5qwpjCF/h0EvfctMXPbaGep7TFcxxG
 4AFMInMe4EA8L0IF+kzXL7bTwOb6MU6EOO39CSvY2RV3eP99404msYyGQ7ikLsOB6pze
 iqw06fFv3FVETFSunnnJ1zvazb79OqBQSLgMpkABXR7qk32GherF2ADuR7vw6K5eTSiv
 JkwQ==
X-Gm-Message-State: AOJu0Yz3T17T2asEVkjsFnLxu+IZ2xkwHpoQmEqPAqLQ1ktJ3iIRl0mz
 60NKIynLnRG2hCom8iJjpOzZEs2Utxe4nrG/JmHwfYsM/CnH/U6auo0XYVi3C+yPq7dtSTQRWPm
 t9JX6RO5G151SFInt83KoJ1Va0uzr8II=
X-Gm-Gg: ATEYQzzQqUKKRM5UuKWoNTeSWmUTBH3Hkly1lh3WrVHyBDrmMFVNLpjyEc9xFIUXlQ5
 ukGsM0AU8OG0YKRkWy2MrBnarfeCT4unsbLevlneZgqfFoFAW6x5kHr8jzmJBvTlZSTyS/GfirI
 FWtxn09leFiXO612SiSfowSXjz9vKbmPPntig+UUCPLrCDwiptDMpUq8f3s//C3JxZlqtOUzgAa
 SHL3wjQ7sBJTbU07UsknmY7tfN51adsDNotMZdbUuKUUcSU80XfUvg7bckePtvCkt6UYyeWY1z7
 L2V0bYhuVk0hZYoy9yHCRU2o2SCYokR3J66CvQw=
X-Received: by 2002:a05:693c:3104:b0:2ba:a3f2:958c with SMTP id
 5a478bee46e88-2c1093d8c5emr5984191eec.0.1774361105202; Tue, 24 Mar 2026
 07:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-8-48eb1dcf7b76@redhat.com> <acKXZhq17IH38Cfv@redhat.com>
In-Reply-To: <acKXZhq17IH38Cfv@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 24 Mar 2026 18:04:53 +0400
X-Gm-Features: AQROBzBet_eKWDhJdGzkhWKCO_FpO0VjHzOfDBtz95efdXFSz8cmchV9MGoMZTc
Message-ID: <CAJ+F1CJpyfnJCjajotDTTqnGwMfDYMn849F2793+WPmgfovURA@mail.gmail.com>
Subject: Re: [PATCH 08/60] ui/vnc-jobs: narrow taking the lock when pushing
 empty jobs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1329.google.com
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

Hi

On Tue, Mar 24, 2026 at 5:54=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Mar 17, 2026 at 12:50:22PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  ui/vnc-jobs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
> > index 28a4738f1ec..ae925171fae 100644
> > --- a/ui/vnc-jobs.c
> > +++ b/ui/vnc-jobs.c
> > @@ -122,14 +122,14 @@ static void vnc_job_free(VncJob *job)
> >
> >  void vnc_job_push(VncJob *job)
> >  {
> > -    vnc_lock_queue(queue);
> >      if (QLIST_EMPTY(&job->rectangles)) {
>
> All the APIs which write to job->rectangles do that in a block
> that is protected by vnc_lock_queue, so narrowing this to allow
> lock-less access of job->rectangles feels dubious, without some
> justification in the commit message to explain why it is safe
> for job->rectangles to be unprotected, while 'queue->jobs' still
> needs protection.

The caller is vnc_update_client(). It creates the job and push damaged
rect. It shouldn't take the lock either. Only if it modified a queued
job it would need the lock, but it doesn't. I'll update the patch.

>
> >          vnc_job_free(job);
> >      } else {
> > +        vnc_lock_queue(queue);
> >          QTAILQ_INSERT_TAIL(&queue->jobs, job, next);
> >          qemu_cond_broadcast(&queue->cond);
> > +        vnc_unlock_queue(queue);
> >      }
> > -    vnc_unlock_queue(queue);
> >  }
> >
> >  static bool vnc_has_job_locked(VncState *vs)
> >
> > --
> > 2.53.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>


--=20
Marc-Andr=C3=A9 Lureau

