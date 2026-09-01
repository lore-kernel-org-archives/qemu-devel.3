Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88748C624D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1RHs-0006KD-G7; Tue, 01 Sep 2026 12:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1RHq-0006JJ-1t
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1RHn-0007Eq-VH
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 12:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788279875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=25fiuP6bOK0DBpPLD1aTgxA0PLNIIfB1Ji8xpraYRSM=;
 b=dUASubra16ISwc7htDsMCZTNHdXPbR0eE/ICH1JjNr6Y6igI+gly3Y8vuoWqAidRqxoUS3
 1jX38vnJjODsX+HP6GopvZUFHrZr7lNsJM0mQYZpIoX1L9tYu4RZPYQn4O56LtjCCS6fT6
 bg/FzkW6eO/0yJ3PtndYDkQQ1XSvIHo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-N7j_WZo-MMm0kfmnZ9xvqA-1; Tue, 01 Sept 2026 12:24:34 -0400
X-MC-Unique: N7j_WZo-MMm0kfmnZ9xvqA-1
X-Mimecast-MFC-AGG-ID: N7j_WZo-MMm0kfmnZ9xvqA_1788279873
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9308eafb465so19793185a.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788279873; cv=none;
 d=google.com; s=arc-20260327;
 b=glsGlcS8fIYbdphmNPZxAH805REiuZOKP96v77lUtmLytD2yaLAxLyHPkRP1ShQ3CT
 hJK8Tty2kTkTchp3gxPytoBrwGPpfkVnx8Yy/gSKspcy5m0LwjqI4qJomxqAtRaNjDHw
 T2df4hVwsxZTeuqPhVdpU5zwjormmV2dhh9gaPVNyNzTvSdJUCSTnPBWyFeyq6WtKmma
 GvT6hgT7CdkvlIjJW728QwB/N1oyeqQkwu5yXzJZcsdd2M8HrBedFsga4C9vN7SKXzkC
 2zOeKSyEmg8TaIB+Am1frX0oEsW11OQBX49PxO/XhGroP+BoFGiwQgnygAc1xBiSBb5k
 ECMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=25fiuP6bOK0DBpPLD1aTgxA0PLNIIfB1Ji8xpraYRSM=;
 fh=xizSxd+jaOv06DKbfuw32B41n2rBki2lFEb8Vushet0=;
 b=T/1b4Qmw9XB3SQXY6NG7bgLwaeti7f20roLvzGPWCcreruzJYf5y/lWJfp8PygUgzf
 DHbGXSNV1Nx5UyuDQA2RGby4KGk5apThpfo+jpdFf2xZDRdRk9VMTD1d+cUeb76nhC+t
 xGM4ABFCcCR5hmWxkj+sTE3IpLip11CO0ixlP6vhxB1syNfPRf96v0BGsV/pGE1h+mnP
 LFDxtMKSw8ArTEYnCkBLjqlrgIrXXuMC0UtGXiLsTte2aiBEz2OMNjKghvchmoqRzFVz
 xUjVfW9vOxGEGTyAC+k6fI2eu+SPoDOonpzjpN5SVFANPCdclrvVcjNUfr7l/2NtIl+B
 qRPQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788279873; x=1788884673; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=25fiuP6bOK0DBpPLD1aTgxA0PLNIIfB1Ji8xpraYRSM=;
 b=RRHpj8/GN9WiyISYwt46j/KZUy8L4EOqGZ+gLMAe7dL7MSpgPFp1PAZSo6ZrIzEKKQ
 0QMGoor3+ulPxGbJD6U081LQY3yP8+Oq8OQa7TMvhM/JxCQtBcoAJ1eLLq+jOEpjF0+V
 sbUnP1yHKUZ2ZYKQ8TU5gHX3H6y8dDeq3k8ACgiEdVrzqMC20Xz7Ixo2A3PsfCnPrdhm
 QzsXA1zEpA8KGxk6Fw03Ee343s4kLC2GAMaYDJgpfQqoX9TH2YclrxdWsEkway69+dnR
 iq7oFfDTRfFcsSpMiM3m5DO3a0nkl15eBa4ng1WFG3TF/lA0D+ajjwTRHZMERjbEJBP6
 7vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788279873; x=1788884673;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=25fiuP6bOK0DBpPLD1aTgxA0PLNIIfB1Ji8xpraYRSM=;
 b=Ew3qQJ/RjtTAsJtcutMzImQbYcHduusB4i2o8OmELtzxqbpqOXCbbA+I7OUxgFLQcJ
 Dct3+ovE7WQU+6jpQlEBDtGILJeAYO5JIN5mQ4KpSYGttO7hQdhexheLdGoVXwQF7EuU
 9vSypT/Dc2OGuJREqMl3pIE6pM/fxTulmKkDekW5VoLmWTm2ljHMS4kvyUdOAllIjykA
 gbJJvRCi+psyrW0vOuf9rqE7frniRyZlzWx19wZyM4iTKullHH/H/pvlYJBXFLEcjxR5
 iBu5uHT6UU719qMAPGUjTMqP1SrzyzkkJAjzZ5oHnIHOSb9/sKwQiG2ATnVXry0s0g3h
 Y3Ig==
X-Gm-Message-State: AFuF++nBEAuCLKF8SD8xj3JeRFvhErYbkwSzHahW/b9xdgAEgwchEGTz
 mVF2bsgsqH0A/hVoXRe1TpwFvwTVLar931EA+v0HpDCFhHQCYr4HKpkAzLI1lPUgJpYxuSkHuI5
 z0LiXU1ayouSlyGwvX7qQpJb1WJfJv1yt9LaCPa/o2fNu8L3BWHLSHDEVlKCKRmtUimaVMdSZP1
 Y8CAhcol66oWqoKY7OtpwnUYOu6wOVWhk=
X-Gm-Gg: AR+sD11e7vjd7HffGnq7xFQ4ESeboncmj97nv/53OUaRqK+jBgHTzHqaFtL55P0zZ/w
 cWqK5Rvz65KqxcuwcOPnOVJDi5p67kgAWaKqCFrMjKv9U4WKXHHHaQmuDcyklOUflWJBEfrxr2S
 9lFY52DiwXMSqdKTMlL25NWQZ6pe42VEHAyhxB3Od+HFz6/qJZrgnemQVjgJwIi7jJ46BkDMiaR
 jZNNKDAUXYpM4E0
X-Received: by 2002:a05:620a:3c09:b0:939:409:708a with SMTP id
 af79cd13be357-939137d1dc3mr3317057485a.13.1788279872350; 
 Tue, 01 Sep 2026 09:24:32 -0700 (PDT)
X-Received: by 2002:a05:620a:3c09:b0:939:409:708a with SMTP id
 af79cd13be357-939137d1dc3mr3317047485a.13.1788279871663; Tue, 01 Sep 2026
 09:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260224181440.832943-1-jsnow@redhat.com>
 <20260224181440.832943-8-jsnow@redhat.com>
 <CAFEAcA_r9n9e10WWqikiNwocrLPTDEofk8gxpi3_7RuA5yu0-w@mail.gmail.com>
In-Reply-To: <CAFEAcA_r9n9e10WWqikiNwocrLPTDEofk8gxpi3_7RuA5yu0-w@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 1 Sep 2026 12:24:19 -0400
X-Gm-Features: AcwNN1VO2mIDf-ZymnR4Fftw-Brppp4-mzH32gamTDT3bJqArqfqTFoFk9miDCY
Message-ID: <CAFn=p-Yg5Z6mbwcJeeri0d2XxeyQQwgpgy8k-+PCLAC_E0nd7g@mail.gmail.com>
Subject: Re: [PULL v2 07/19] iotests: tolerate being run outside of pyvenv
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kyle Evans <kevans@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Warner Losh <imp@bsdimp.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Maksim Davydov <davydov-max@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Ed Maste <emaste@freebsd.org>, 
 qemu-block@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>,
 Hanna Reitz <hreitz@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 1, 2026 at 6:14=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Tue, 24 Feb 2026 at 18:15, John Snow <jsnow@redhat.com> wrote:
> >
> > Modify the iotests environment preparation so that it can detect when i=
t
> > is being run outside of the configure-time virtual environment and give
> > a warning to the user, suggesting the use of the meson run script
> > instead.
>
>
> > +        if self.python !=3D str(venv_python):
> > +            runpath =3D os.path.join(self.build_root, "run")
> > +            cmd =3D ' '.join(shlex.quote(x) for x in sys.argv)
> > +            print(
> > +                "\n\033[93m\033[1mWARNING\033[0m: "
> > +                "iotests is being run from outside of the configure-ti=
me "
> > +                "python virtual environment\n\n"
> > +                f"current python: {self.python}\n"
> > +                f"pyvenv python:  {venv_python}\n\n"
> > +                "Individual python tests will be executed inside the p=
yvenv,\n"
> > +                "but the test runner will continue to run outside.\n\n=
"
> > +                "\033[1mPlease use the meson run script:\033[0m\n"
> > +                f"\t{runpath} {cmd}\n",
> > +                file=3Dsys.stderr
> > +            )
> > +            self.python =3D str(venv_python)
>
> I just noticed that our CI triggers this warning, e.g. in
> the block: [parallels] job:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/16226916350
>
> WARNING: iotests is being run from outside of the configure-time
> python virtual environment
> current python: /builds/qemu-project/qemu/build/pyvenv/bin/python3.11
> pyvenv python:  /builds/qemu-project/qemu/build/pyvenv/bin/python3
>
> Presumably something here needs to be fixed so we run our own
> tests in the way that they expect to be run ? Or does the warning
> need to be adjusted so it doesn't complain about the difference
> between executing the same python as "python3.11" vs "python3" ?

Looks like it just needs an adjustment to the heuristic, yes.

Normally I'd say we should resolve all symlinks, but as venv python
executables are themselves also just symlinks to your system's python,
it's not a reliable indicator of if you're inside the same venv if you
do that. We have similar code in mkvenv.py that can probably be
leveraged here, I'll fix it.

(Hey, cool, all of the info I put in the warning was useful for
diagnosing the issue without going digging in the code. Awesome, I
love when little affordances I put in the code pay off for me in the
future.)

>
> (The actual failure of the job I think is unrelated, it's just the
> reason I was looking at the log file and noticed teh warning).

I agree.

>
> thanks
> -- PMM

Thanks for the report,
--js


