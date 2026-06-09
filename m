Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF719CD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0XE-0002wn-3l; Tue, 09 Jun 2026 13:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wX0X7-0002pN-1b
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:46:37 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wX0X3-0005IN-Ug
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:46:35 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-69155ca09d8so4357931a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 10:46:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781027192; cv=none;
 d=google.com; s=arc-20240605;
 b=EU2tV7j1OJDEVfOb0g1xNTYIbXAV+4lVXkApdNcDaybTqgLOXATzIAJwGU+qFtFVdR
 YZ01IexxkUJr+9AAYSCh6/dKnLxaGZd2oj5gbS5HpcMr5+mw/eV9BdLqZwAAFyA1RLFJ
 4QaDXHxDjzXiL8OfZp1tHGyPcO0GSZN8F5umgoGlhav4n+Alh7vTOx2dgdcCRiBkIhUZ
 sbmPtDqKt3bPH4YASU16K9RvclfOGixuQYuC5ufsPQJGKlvAEt6skRvIIjp62phmEgrO
 QDiwPrDcMQXib+w/2uSYgfnF98frY7KHeAroXHR16aurQ0jL7pngD6AtR7RI7o6sfK3x
 pAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7obKr5/vRI2fbVaKLdM57/gHEh2hU8cVhekM3BWuUlo=;
 fh=AsjQTlV1S7YVEes6wLpuDpFWFNIiRqP2PnjQ3ibT1hM=;
 b=K9aq2NSE5HLasTfSv6Sw+RD5K9luK5sZ45NMt1aUKBHhRIdMIMSsF43IUDEBgzWSJJ
 LebhrPfgz3p0y8jlUaLBTLArogxGVWD2dplEfyMylVcXoiEZJmc6dBfFP0iTQw/I5y0C
 0ZH9j6rJgjdvECItkMUmLCWUk9MeA1Nx5Mf1JxEnhmkusCrRL+xqxAmczlf0RuHt77d6
 4RJ2ZaOzvPmvsrVi7M2SbkIl8UsLujgoXSiGNX6OyUwlZY7oSH8WJXBwQ4fj80u54cFl
 98wn8oOIQBXGAHY2REFqFpiiXevwnfW2eg90bm/EDsVJx+XTDnrIHk4Pwv2E0j7wa/8v
 EhOQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781027192; x=1781631992; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7obKr5/vRI2fbVaKLdM57/gHEh2hU8cVhekM3BWuUlo=;
 b=CRl4TYer843Qhtnu8U/jI8AEqo1tvVlYuchKR606SQ+Iwqdf9fNa0cAsyrxW3RiWOc
 G/4fSOTyS87i82uu1kYP6w9g5enJZbRQR67ZCIuxKaz6EF4kUp2U/Rd6NlTYowU8wLpQ
 IIvgJNFH3QGzh1oF2EkTSVjYuhXFIthjO9AdyXT3nCPdnSIv2hjQoPqSfHYPMgrS44lT
 a/Li67zSpaVbsTKiPXE+k39CwF1vYvZHlL6cqyTsqsRfkpoU9PVSbvZjGjjs9P/Ct2QI
 Cw7v/Cn6ZbaBdszROtUxZsLTWuMURKj1MiNv7SzyKLjPKjnQdNBAl6CI7InAjlDI7k8e
 7fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781027192; x=1781631992;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7obKr5/vRI2fbVaKLdM57/gHEh2hU8cVhekM3BWuUlo=;
 b=nqYnixmKwztflIg7d6zuAxqIdjIOWdSWR5+yVdAv5aXFbE/3FVjlSq1zM6wxracG9N
 AZRSpOQdzk0DazLW8XuR138MqC7qbOZF6fomN2yR0jeC1S7NnOEvxTnhFTZuhbQf5tbl
 +3k1ftiJj/hpb/wky3yqIRZsMAXIW7VmToccfaGXA5NyaBVEAmsI4J/cpwcN134ixRi5
 8psfLObmdt1gVRjO1qzDneoTIiTBrRKc6aa+y9HYf3GNzN+wLAWaJuba8UoiKqU/+ICv
 JNlF4X5A4/+CfnMChj2Ngraa9HVgNsKajAXsvL2GJVIWIWPaPMVey0W7M5YV15mvmy3+
 JZCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+OKZLioU/aluxEpdndjb4cAItOMwm88d1Uc0S/qfFIk9IuxqQGDJzOgJm6b4vIWlX6IFbkvlDZNw8C@nongnu.org
X-Gm-Message-State: AOJu0Yw8ojay1t1x7vIJFfaS3O++XHppXCij5AN4GEQI2PzQBFT8Y+Lt
 MWe04UBtF0uJDBdD/tiGvDqA2m6LYCNrKrBX+wa5k5jhMLgN+pHicuZvyRfa2P/e/andA0Ep2dN
 TzNzptZdHLERrehbeDaLR6XH4ZPevrd4N2A==
X-Gm-Gg: Acq92OFDw0ss8eEHXX8cHnOaa6y/lERFQ8qx0rGA7CPnQ5MyeuD3/fzd7QsNFazl+cJ
 qUlMHMe+ypBjmVN25M8yqwbnlqI7k6KONb2KrLPItBVS4d/LAWBy3i0hfTlZpXKQMfLnLE4q3jB
 MzVSLg+k5+arP6dXCQNZz6msPIJEb6JG3lbm3CRrJ8z1wezbh/Eqd2MNl7bnaO0uAB5rY0ifUnO
 67YNQfO7FYZFmyUYJ+UPE0SxYP/GquTVlzYbnxqHcOIdxe7/adbhaF3idiFhB3yutlyxikpKCSb
 yoXBIDtBrBLJBqqlkfK2HMHJC9LKRgBXknwAMPIeawT2qiBFp9jgYO7gsCyCSb8=
X-Received: by 2002:a05:6402:42c5:b0:691:9600:e8ba with SMTP id
 4fb4d7f45d1cf-692381fb3d3mr2125537a12.1.1781027192218; Tue, 09 Jun 2026
 10:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QU6Ko87bYaaNm6DCB7krVZgbo_YohuVKSAunBpnDJFdHA@mail.gmail.com>
 <aibWM_LYrgnBYQQg@redhat.com>
In-Reply-To: <aibWM_LYrgnBYQQg@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 9 Jun 2026 13:46:18 -0400
X-Gm-Features: AVVi8CdGsC0BfVTBHXgfotETE9lTo3hWDQfFURSwadiSCZOEBqe2dT20tpuXfS8
Message-ID: <CAJSP0QVAogkXDcBEoUSAxFqT6Pc90=HxcntexuHOFZYggUNCyQ@mail.gmail.com>
Subject: Re: Race condition in qemu-iotests nbd 205?
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu block <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
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

On Mon, Jun 8, 2026 at 10:48=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Mon, Jun 08, 2026 at 10:23:18AM -0400, Stefan Hajnoczi wrote:
> > Hi Vladimir,
> > It looks like there is a race condition in qemu-iotests 205 when the
> > NBD server is shutting down:
> >
> > +FAIL: test_remove_during_connect_safe_hard (__main__.TestNbdServerRemo=
ve)
> > +----------------------------------------------------------------------
> > +Traceback (most recent call last):
> > + File "/builds/qemu-project/qemu/tests/qemu-iotests/205", line 149,
> > in test_remove_during_connect_safe_hard
> > + self.assertExportNotFound('exp')
> > + File "/builds/qemu-project/qemu/tests/qemu-iotests/205", line 63, in
> > assertExportNotFound
> > + self.assert_qmp(result, 'error/desc', "Export 'exp' is not found")
> > + File "/builds/qemu-project/qemu/tests/qemu-iotests/iotests.py", line
> > 1246, in assert_qmp
> > + self.assertEqual(result, value,
> > +AssertionError: "Export 'exp' is already shutting down" !=3D "Export
> > 'exp' is not found"
> > +- Export 'exp' is already shutting down
> > ++ Export 'exp' is not found
> > + : "error/desc" is "Export 'exp' is already shutting down", expected
> > "Export 'exp' is not found"
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/14745043965#L328
> >
> > I have not seen this CI failure before, so it might be rare and hard
> > to reproduce.
>
> FYi, If you don't have time to investigate & fix it quickly, just
> file a gitlab bug and then annotate the test cases / clases with:
>
>  @iotests.skip_flaky("https://gitlab.com/qemu-project/qemu/-/work_items/N=
NN")
>
> which will make the test be skipped in CI / locally, until someone
> has time to look at it.

Thanks, I'll keep that in mind for other flaky tests.

Stefan

