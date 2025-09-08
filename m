Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA8FCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 17:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvfrH-0006f8-2j; Mon, 08 Sep 2025 13:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uvfqz-0006ca-Oj
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 13:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uvfqo-0000mO-R9
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 13:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757353213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rOS6ywG29J6dgRWaRK7FXo8q4BFXpPL8Q04JQDooHiA=;
 b=UizJqQs3yZoHvIX/Y7Vte24daNgXmJoSjdJ5roz2700KgmpjEX8MYGD7ao6eVuP/yBjHni
 K/aYvE9e000QigzNOnM/eem1F8B2YcCprKdRefXG+RSoJYzzvMwnaHB6q0AWkCZW4OZ7s3
 qLrdExIMUmQLY4lRo3eHTQILbEp6yDA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-9dqZ0WqyM0CsmT46pYuAoQ-1; Mon, 08 Sep 2025 13:40:11 -0400
X-MC-Unique: 9dqZ0WqyM0CsmT46pYuAoQ-1
X-Mimecast-MFC-AGG-ID: 9dqZ0WqyM0CsmT46pYuAoQ_1757353211
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-32bdfd536aeso2634485a91.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 10:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757353210; x=1757958010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rOS6ywG29J6dgRWaRK7FXo8q4BFXpPL8Q04JQDooHiA=;
 b=TWHhhSoYLXh7F7VkHP6ZR3MOKO85dG+BhT5vAcBlQwm0f6OJpnMz8MfTavRcLIYzzN
 hKE2t08ze00XiZtIKvovKnNjvMvzzaEV7Y4MVmy9Yxt0PCN9Z0XuORsXTyI20nMyqBHs
 czAakLoNyxjWHcNukBzrc2f82pZVztdBnUcyCdGT7VeKFFtLtvOrGDt4dBcv0+LaGqB4
 xrTRXqhUhBN/3RRNP3Q9VNxXX5FkGKAOOw5IYmrei4n8ujOm/5mkDNhwGkWC/uitrr0p
 MpjRpwdwEQAORQR2zXQocwGOpn24jJwTYdEOtMYVooymX8LnE61MwT+oi3CtLPc2EEmC
 I18Q==
X-Gm-Message-State: AOJu0YxockqZzzHLkpe4qdJlJZ+5yFR0qkHG2RzX7XZ7/6xo9YnON0sz
 69y9MPAAPtBKPDTCiYaY398TrANWLv3cmYQXf3NZPnVczGgOQE6fhffCH7FVL9f8innvrWk3gmN
 1PAXTFv3b9+2XNQIsaWTtMZhHWosMurjBQfd4+i0ESG1WGU3PcA0QQ7uL1mTPZxa3tVbaYzRvfG
 dgEJgEwPWoJeulMmnxSE/4jKRbuX5zfDs=
X-Gm-Gg: ASbGncvvCylmo8jfLDygH1nUc138VPDh7GPbtE2e2raAk0ONUZm2N9E/Gs0iKou2yAS
 gudiynVb2ddUpeMAS/nyefvY2k0oMWhtE3wbTmaoTyP6eix+MBJIUrrGcGc68GYKvDapxWwpoND
 UHPz6NmAaJx/cviFZtRXPAmCqB51zDMnWtwwrTzujiK9+4QTeGhG+r
X-Received: by 2002:a17:90b:3d8f:b0:314:2cd2:595d with SMTP id
 98e67ed59e1d1-32d4504c45fmr10669057a91.8.1757353210537; 
 Mon, 08 Sep 2025 10:40:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7HKwGcu7wCYuFWaxtB5Gqqi236DWbwnqFvqkyvJeyGcyuiiUR/P5rdLUmK4YPD9yZwF2qzHS3EAMROX1g38A=
X-Received: by 2002:a17:90b:3d8f:b0:314:2cd2:595d with SMTP id
 98e67ed59e1d1-32d4504c45fmr10669029a91.8.1757353209915; Mon, 08 Sep 2025
 10:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250903051125.3020805-1-jsnow@redhat.com>
 <20250903051125.3020805-7-jsnow@redhat.com>
 <aL8IsV55wwhSxSeu@redhat.com>
In-Reply-To: <aL8IsV55wwhSxSeu@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 8 Sep 2025 13:39:58 -0400
X-Gm-Features: Ac12FXz6iHgQfQjFpaR4vP-sSiNkQmd4xbObWgRPEdKLgcZnzZB3sl8w6OV_slc
Message-ID: <CAFn=p-aTVUng3s7zU1Kpy4-jCsrXkKAbVPKw-ZACKmvL1Sy0eA@mail.gmail.com>
Subject: Re: [PATCH v2 06/18] python: backport 'qmp-shell: add common_parser()'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Cleber Rosa <crosa@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 8, 2025 at 12:47=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Wed, Sep 03, 2025 at 01:11:12AM -0400, John Snow wrote:
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > cherry picked from commit 20a88c2471f37d10520b2409046d59e1d0f1e905
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Duplicate s-o-b

One is from the original commit, the other is from the backport.
Wasn't sure if that was truly needed, but figured it wouldn't hurt
anything.

>
> > ---
> >  python/qemu/qmp/qmp_shell.py | 35 ++++++++++++++++-------------------
> >  1 file changed, 16 insertions(+), 19 deletions(-)
>
> Wierdly the diffstat when I looked qmp_shell.py is very different
> from what your patch here shows, but the end result appears the
> same. Perhaps one of us has different settings for $HOME/.gitconfig
> that affects diff display

Possible. I didn't exactly take care to preserve the commits
themselves exactly as they were ...

>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> >
> > diff --git a/python/qemu/qmp/qmp_shell.py b/python/qemu/qmp/qmp_shell.p=
y
> > index 98e684e9e8a..02028e94b5a 100644
> > --- a/python/qemu/qmp/qmp_shell.py
> > +++ b/python/qemu/qmp/qmp_shell.py
> > @@ -514,21 +514,27 @@ def die(msg: str) -> NoReturn:
> >      sys.exit(1)
> >
> >
> > +def common_parser() -> argparse.ArgumentParser:
> > +    """Build common parsing options used by qmp-shell and qmp-shell-wr=
ap."""
> > +    parser =3D argparse.ArgumentParser()
> > +    parser.add_argument('-H', '--hmp', action=3D'store_true',
> > +                        help=3D'Use HMP interface')
> > +    parser.add_argument('-v', '--verbose', action=3D'store_true',
> > +                        help=3D'Verbose (echo commands sent and receiv=
ed)')
> > +    parser.add_argument('-p', '--pretty', action=3D'store_true',
> > +                        help=3D'Pretty-print JSON')
> > +    parser.add_argument('-l', '--logfile',
> > +                        help=3D'Save log of all QMP messages to PATH')
> > +    return parser
> > +
> > +
> >  def main() -> None:
> >      """
> >      qmp-shell entry point: parse command line arguments and start the =
REPL.
> >      """
> > -    parser =3D argparse.ArgumentParser()
> > -    parser.add_argument('-H', '--hmp', action=3D'store_true',
> > -                        help=3D'Use HMP interface')
> > +    parser =3D common_parser()
> >      parser.add_argument('-N', '--skip-negotiation', action=3D'store_tr=
ue',
> >                          help=3D'Skip negotiate (for qemu-ga)')
> > -    parser.add_argument('-v', '--verbose', action=3D'store_true',
> > -                        help=3D'Verbose (echo commands sent and receiv=
ed)')
> > -    parser.add_argument('-p', '--pretty', action=3D'store_true',
> > -                        help=3D'Pretty-print JSON')
> > -    parser.add_argument('-l', '--logfile',
> > -                        help=3D'Save log of all QMP messages to PATH')
> >
> >      default_server =3D os.environ.get('QMP_SOCKET')
> >      parser.add_argument('qmp_server', action=3D'store',
> > @@ -564,16 +570,7 @@ def main_wrap() -> None:
> >      qmp-shell-wrap entry point: parse command line arguments and
> >      start the REPL.
> >      """
> > -    parser =3D argparse.ArgumentParser()
> > -    parser.add_argument('-H', '--hmp', action=3D'store_true',
> > -                        help=3D'Use HMP interface')
> > -    parser.add_argument('-v', '--verbose', action=3D'store_true',
> > -                        help=3D'Verbose (echo commands sent and receiv=
ed)')
> > -    parser.add_argument('-p', '--pretty', action=3D'store_true',
> > -                        help=3D'Pretty-print JSON')
> > -    parser.add_argument('-l', '--logfile',
> > -                        help=3D'Save log of all QMP messages to PATH')
> > -
> > +    parser =3D common_parser()
> >      parser.add_argument('command', nargs=3Dargparse.REMAINDER,
> >                          help=3D'QEMU command line to invoke')
> >
> > --
> > 2.50.1
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


