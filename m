Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD517C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvsNt-0005iA-Sx; Mon, 17 Aug 2026 04:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wvsNa-0005h6-RP
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 04:07:34 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wvsNZ-0007MX-63
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 04:07:34 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-ca88130e09aso1779209a12.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 01:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786954051; cv=none;
 d=google.com; s=arc-20260327;
 b=kkPM4v9gZqOQ9LNXKCcAxGOAhClLrA/AxtLIZ90kKPf9Q9I6GNYbJWevIsTC0NLLrC
 l5W88uXS4v/gUfQyRc/7mnJbNsMwyxCOSPLcce3BWHllij4/QYQTjQALmmbz9s1DtqJQ
 p0SP8cm/4a3DDAJMJpag39//wzGnRXQUQwYBiMSRhbdb6Z6Ajk/KbHwabSg8WwLpbUI7
 6dROuIRUFzEQHGv+rroCB7tNW/CKmFM+3kXaiy6UhDDzxZbBkPtZShiHS9BReptdPcyM
 KdV+AzzixAlO6lKJ9GRaRo7vO/U+N76NTgsV+FwnXwnn39yMUYrylPBkOIsqpcAPtKeU
 T2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9P7sq1R4F9/RL0UXsVvl0jR6q2poIwVaI/su6o8ImM8=;
 fh=ThhFgrYixJkIgYSqLgA55gUpVE6zAy+ETaevrM1xZ+w=;
 b=fVGavxBH15kx5g31p4sKgZ8BId7aqMuv7tyV4sH78pYYuCsYYTNXa48DwnXg19iKcY
 AEPH7hyXPmwZDjQsc1XcJ3erOebPJaxVlLdrGbf+csVSc9rtaDpZpQIMChsdhjPMvJ0w
 57PAgsCBU+qmSD5p+axuoSmyfNgs+rjS4fQe4OKhGQLoHuN/fHkTk7S7dF5rYHS6evGI
 MMCdi/A5+zyTnUbhj2sfrTUH9N+x3VPdcnaTierU9WUEY0tV/O7Jagszov1rihqR/Me0
 WD2LFxD5QfNTd6FYdeyKFGiQEeXYtu0pVBfVa5jR0rRBUo9lPuAmuSzfLcKd6NIatg94
 8Ydw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786954051; x=1787558851; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9P7sq1R4F9/RL0UXsVvl0jR6q2poIwVaI/su6o8ImM8=;
 b=Z0x7OUKgUxqCXY3Z7Yw+xxBJ5HiiG68kofnSKHKROpVicDSFRWtNsl16/YFoVohQU7
 CFr30srG9jwrf4g7Q0Z4yYe6VoPRMpXsbh0hu0m0Puz9hF9TqCAq+I0CU4aojb3N8QfF
 Tid4w8ucy5n740f6lom3tu/Dl48qaaulLXBdwWcxsw/5f7Fv2sm/Cn8tnSrNrJOP3oV1
 3UUOrOs1z0bxoMOvTszbLdLaUzNsa/5LfWkkW5TWpVQEIK5JcYTwkt3499d+c9U70W8v
 IRrShUrC69N/QHBPAneeySARfPzTd9aBwspmJRhVb7E7Zrog1AxqhTcVBgMXbhxjXnFc
 WYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786954051; x=1787558851;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9P7sq1R4F9/RL0UXsVvl0jR6q2poIwVaI/su6o8ImM8=;
 b=gpJPpZtoKUDgsGUZasdNb9a2u3vRJzfaxY+JRhWIu8v9SnpaZuNjYFOaGt3AY72CZZ
 U2ZIdKHQcb5//eAGh7ZjkZJ/ujaq0GYSdoDgB4DV8bBdTeXogrgoqI5P/pWfjGWoINXj
 zHhaFGNVXEa3T2bvCcUMTJnb7G7h5PWXksYuRFmmVcUHCKzS+HauJacDSx0oMJNrcatu
 r7fKepb0z+QnwHV/yMmilMQjCginIf2dWklAS3gjAhudiuTg0S2oofgl4gt2cU+xzpUt
 JhdqADuVttj4avflBzNRWHN8eEIl8m4u7nLUj1dl32f0PYktRHrdiFqGU/t77yecnnbp
 /mCQ==
X-Gm-Message-State: AOJu0Yz0OK9CtcR5PEf9ido/i22p5bld3Zgdq7ladfDiX3/41rMXgXre
 RhQkbvCBRe4oUkCAUU4yMK0fq9inhcdDNvN0DQp6LjcNw/BLU3jk5MMxt6RAv7dwxOoUaOXx5Cp
 3aYdBhEFX1WNFiul9Xl6Vd4nDdl21Pvk=
X-Gm-Gg: AR+sD13AvhA0fE8O2iEXjpVJinywngv8lFP6PY4YMq6Ibuqc9VKbCsrXRPmfW4ld7mk
 cCKCO9M1utWGoxMAnTYi0W4D4xEJJYjePsY/u3doJiVceGymBGiOHDQZiqX9Nsf+s/XRV/ewK5Z
 fID8uhJoD3hqsG4/C6yJhWeV19B12r2U/BhwyYRLgLjd04KWpRUFwO4GTsJhlzvVnfXi+0028gX
 hq8kLwUXk5NJIskWhhrZN+boNHaG7vdnSN0RwP2TewEB4A8cgS1WmJ77IQl+NV36G1iH+buhC/K
 ktX60na9Qi1ma6/VYJX9ucaXXOwUSSA7s1QuNk2muvjNuvHWKNmKajGK8QZFngogoMMK0BfhJeg
 G/Qd4p3megMY=
X-Received: by 2002:a05:6a21:920e:b0:398:c0ba:9ceb with SMTP id
 adf61e73a8af0-3cc71a40f7cmr27716208637.12.1786954050634; Mon, 17 Aug 2026
 01:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-11-e53fc35bc550@redhat.com>
 <8105c239-3730-4131-8f17-20de1bd85599@posteo.de>
In-Reply-To: <8105c239-3730-4131-8f17-20de1bd85599@posteo.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 17 Aug 2026 12:07:18 +0400
X-Gm-Features: AcwNN1WhxlzR4IqZW74GVQ0X7w-6F3Svu6N4TnYh26tEB5EUnIYI73rS9tpPhl4
Message-ID: <CAJ+F1CJeiAygk5Qn8EFeiuY=dXkKDdQBzkMpdYVreKFO0jKj2A@mail.gmail.com>
Subject: Re: [PATCH v3 11/49] python, tests: switch usernet queries from HMP
 to QMP
To: Thomas Huth <th.huth@posteo.de>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x52f.google.com
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

On Mon, Aug 17, 2026 at 11:31=E2=80=AFAM Thomas Huth <th.huth@posteo.de> wr=
ote:
>
> On 16/08/2026 21.12, Marc-Andr=C3=A9 Lureau wrote:
> > Replace human-monitor-command "info usernet" calls with the structured
> > x-query-usernet QMP command in get_usernet_hostfwd_port() and the VM
> > test runner boot path.
> >
> > Since x-query-usernet returns a list of UsernetInfo entries, callers
> > now iterate over the result and extract the port from each entry's
> > "info" field. Also switch get_info_usernet_hostfwd_port() from
> > split('\r\n') to splitlines(), since QMP strings use \n rather than
> > the HMP monitor's \r\n line endings.
> >
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> > ---
> >   python/qemu/utils/__init__.py       |  5 +++--
> >   tests/functional/qemu_test/utils.py |  8 ++++++--
> >   tests/vm/basevm.py                  | 13 ++++++++-----
> >   3 files changed, 17 insertions(+), 9 deletions(-)
> >
> > diff --git a/python/qemu/utils/__init__.py b/python/qemu/utils/__init__=
.py
> > index be5daa836340..e32911d4c6df 100644
> > --- a/python/qemu/utils/__init__.py
> > +++ b/python/qemu/utils/__init__.py
> > @@ -46,10 +46,11 @@ def get_info_usernet_hostfwd_port(info_usernet_outp=
ut: str) -> Optional[int]:
> >       """
> >       Returns the port given to the hostfwd parameter via info usernet
> >
> > -    :param info_usernet_output: output generated by hmp command "info =
usernet"
> > +    :param info_usernet_output: output generated by "info usernet" or
> > +        the "info" field from x-query-usernet
> >       :return: the port number allocated by the hostfwd option
> >       """
> > -    for line in info_usernet_output.split('\r\n'):
> > +    for line in info_usernet_output.splitlines():
> >           regex =3D r'TCP.HOST_FORWARD.*127\.0\.0\.1\s+(\d+)\s+10\.'
> >           match =3D re.search(regex, line)
> >           if match is not None:
> > diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qem=
u_test/utils.py
> > index 826c267785bd..0992db49ab28 100644
> > --- a/tests/functional/qemu_test/utils.py
> > +++ b/tests/functional/qemu_test/utils.py
> > @@ -14,8 +14,12 @@
> >
> >
> >   def get_usernet_hostfwd_port(vm):
> > -    res =3D vm.cmd('human-monitor-command', command_line=3D'info usern=
et')
> > -    return get_info_usernet_hostfwd_port(res)
> > +    res =3D vm.cmd('x-query-usernet')
> > +    for entry in res:
> > +        port =3D get_info_usernet_hostfwd_port(entry['info'])
> > +        if port is not None:
> > +            return port
> > +    return None
> >
> >   def pow2ceil(x):
> >       """
> > diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> > index 9e879e966a36..198b04e8c375 100644
> > --- a/tests/vm/basevm.py
> > +++ b/tests/vm/basevm.py
> > @@ -312,12 +312,15 @@ def boot(self, img, extra_args=3D[]):
> >           self._guest =3D guest
> >           # Init console so we can start consuming the chars.
> >           self.console_init()
> > -        usernet_info =3D guest.cmd("human-monitor-command",
> > -                                 command_line=3D"info usernet")
> > -        self.ssh_port =3D get_info_usernet_hostfwd_port(usernet_info)
> > +        res =3D guest.cmd("x-query-usernet")
> > +        for entry in res:
> > +            port =3D get_info_usernet_hostfwd_port(entry['info'])
> > +            if port is not None:
> > +                self.ssh_port =3D port
> > +                break
> >           if not self.ssh_port:
> > -            raise Exception("Cannot find ssh port from 'info usernet':=
\n%s" % \
> > -                            usernet_info)
> > +            raise Exception("Cannot find ssh port from"
> > +                            " 'x-query-usernet': %s" % res)
> >
> >       def console_init(self, timeout =3D None):
> >           if timeout =3D=3D None:
> While you're at it, may I suggest to move the cmd('x-query-usernet') into
> the get_info_usernet_hostfwd_port() function in
> python/qemu/utils/__init__.py, too, so that the callers don't have to tak=
e
> care about this anymore? Also just return the port number from there, so
> that the callers don't have to take care about the parsing. WDYT?

Good idea, but not so simple. qemu/utils doesn't depend on any VM/QMP
types.. we could use duck typing or other solution. I would rather
defer this for now

thanks

