Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454BCC531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogOK-0003dT-TP; Tue, 28 Jul 2026 07:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wogOJ-0003dB-T8
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:54:35 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wogOI-0003T9-8g
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:54:35 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69f2c67650aso5894740a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:54:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785239672; cv=none;
 d=google.com; s=arc-20260327;
 b=cRlc6h4qukYW4mPfVUC0IBV3pihWtfYVC3jwX87/dhCBCa6vFqzyEC4/ksS8MEEobW
 Pg6dTJtZe1ZPAlikO1rGXnpTE62Lc0mhsesSTcOdNYpwK3PhRh0v1xtpLfnqQ14dbRTB
 L2V0UwrFu1lzjyj7zRoClulnUI0eBGdo1MIhjN6l1u2cUz1HF2dKjju8AanV4YIOen+K
 3bb7uRoG2ZaaUUexYjmrpVJxcgBAci+oAkeEO2rSo2Njw7S6ddPid3QiVgva6DmSYyTs
 viBfE93TB4YZvDy/65Zejg6JcpW2Ym2NvbuI/Y7uETec+qKZj8cWX4I5QoDAsN/OHATV
 vuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TCToJWvJfRyrR0jqpHboirR71JfmGpfG7tWSem5nL4E=;
 fh=tjNm5tq/l5hSIYRh5KJ6fWlxXh51w7XSCiX1DyJ8gxY=;
 b=ew9H8XxzyofIMe8Q3AYNKOySvqDYxiAyXmIuvfFcpA9+sYQG3fPVHtWqIQbNxHLIBX
 YCWdKxUJW6IvZUIZU1msDXRv2y4IwdfFcodAH76BCAb/eV5KW+nXBA4Q31dFQEAILDSf
 ylY/ASLCi1bO9WXYir6imCPQmYtnZKoaW39u3p1GfecnBgQJCT0vFNWgnhf2dOf9Y+d4
 kljGjSpP2ra0jaSn40XWdMsAk21nYO5J3jyhECdfbzK8cXWUmzCNZ/qCFizwxvPnefZ5
 LAhWk4aXWEJELOT0HWR8EOZ2+OldUTCnhPfgXKx/1JnyfqLamiSL1jKCnZTUU5zPKEOW
 VG3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785239672; x=1785844472; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TCToJWvJfRyrR0jqpHboirR71JfmGpfG7tWSem5nL4E=;
 b=PCFiSty8Zz0uqiQKOMqdwu73lmAQMxlQx8hU2vgPaspUnwpHasEwzHsomjNlsWyYe+
 m9g1ioeR0ISW2Y9JLx7u/u8ruyk9ty+EZmCF5X1NLwZZx0Hkzu2yd7jTRhFdX87NqQDV
 udAPgEPx5Y/SmaMw3xwAj0f7V3uifTsDDO/2e+A+5TxX3WjikU0gbgbXImKlNm7ShB7i
 a2KkrK0lPaw1hDlTyuQ/o54aoi1GOL2t1Y6PDtE1K36IIsHVjtKMwUoL2aFWk2gGsSiO
 QODbcklotHgC/yFFZ8emm152rtG8+o7V30yIbuKFyUqmkkjyFrjDXf7ZV0WLgHuA5wvO
 Mfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785239672; x=1785844472;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TCToJWvJfRyrR0jqpHboirR71JfmGpfG7tWSem5nL4E=;
 b=CmGyXU4mnxW1XhByNDhaXWnDNxKtiYnBwt9OhyG9BDu+Lb8qxnuGmKs2FFN677tPkM
 69HeOsmp4jgDPoA0UCWOSexjShEvR2bFUPD+LR4c46gSWh61NOo5vFcPK0UMsHipEHwi
 3hdCa7VdgAcLbHibSceoEd42lk7WVuxf7uI4J9TVxEF1JuD7YLhCgu95+bSlOTPkpzJd
 pIFDirtqjmJ62JJwSnoPUk23XjTUw0KTyllLjgYFKN23pllM1oBBpehvsGbcN1OvUJ8k
 4NWZj+BVPtstRhnfrApd7G4utBXh8U1p+5cXMuS8NvpzbMQCmAMOx9rBdwPvQk/TUgUI
 Z4hA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8zyqUQ9D3G6YP323Ev+gAlvaloGKnOSUkyynFGFi376jGF/3xH6K8GT0XuF/MXWRV6NQp7Y7MT+An@nongnu.org
X-Gm-Message-State: AOJu0Yw1MFWDKB98wTpXbioTGlyWyi1aIfWTPhh4t9S4UYp4IM5Y+Aro
 6NvnT1oD4jGVsjSI/jWKs689P8/pUhCNRNi81MoZzMOmM9d7z5l2TO+fnavF9mP1dGi36n04bM+
 nsAmDpa7ygcVCxmHb6ECQtkL5DmAaV6A=
X-Gm-Gg: AR+sD12YXOteFSmvgGa4XYe2cOmVBKv1sPUkgBDnkBsJUwi6cEVUjSYxi6XhLIkhVsi
 WETJgec7AjmmmLSdXejvmy/jgNzHq9Aih1ANh0i+fW4xvg8rAwapyTZORnVADYS3T9Bz79o6kXp
 6krfzVLTRDpjsGetXHFEzMkBiP4ALODJP1rA5WzpjS9jyZeXExfN+KJIXNqNLBswCWjnSryIO8N
 om2n9rgGB+9RBJ17jfAAhaN6qctvQDuGVQeh+bXluHNN46Q5tnwGkdOLEc6LmrpE8osVM1Ipcbi
 vcMOvj+ujVakPq7wtik=
X-Received: by 2002:a05:6402:21d4:b0:69a:bce:f1de with SMTP id
 4fb4d7f45d1cf-6a034a5efe5mr1033867a12.26.1785239671433; Tue, 28 Jul 2026
 04:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260726193636.110586-1-deller@kernel.org>
 <20260726193636.110586-3-deller@kernel.org>
 <CAJSP0QVMP8dPx4-123C8HtryogHyhcwBRdFUe5HcfGu8i2EbJg@mail.gmail.com>
 <071e926e-afee-4b6a-80b7-b475d3284833@gmx.de>
In-Reply-To: <071e926e-afee-4b6a-80b7-b475d3284833@gmx.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 28 Jul 2026 07:54:18 -0400
X-Gm-Features: AUfX_mwUiUASPv6Z7dYrLPgLV6h79oI3mgFcsOeqD-M6MkZFbW4AwkLeaUiPhx0
Message-ID: <CAJSP0QVoP11zVbsMHNkNFCzxTN2zc=dkAdKSVNmxfsBpsyxRZw@mail.gmail.com>
Subject: Re: [PULL 2/2] linux-user: fix guards for the fsmount(2) syscall
 series
To: Helge Deller <deller@gmx.de>
Cc: Helge Deller <deller@kernel.org>, Matt Turner <mattst88@gmail.com>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52b.google.com
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

On Tue, Jul 28, 2026 at 6:11=E2=80=AFAM Helge Deller <deller@gmx.de> wrote:
>
> On 7/27/26 16:15, Stefan Hajnoczi wrote:
> > On Sun, Jul 26, 2026 at 3:36=E2=80=AFPM Helge Deller <deller@kernel.org=
> wrote:
> >>
> >> From: Matt Turner <mattst88@gmail.com>
> >>
> >> The fsopen(), fsconfig(), fsmount() and fspick() implementations are
> >> guarded by defined(NR_fsopen) rather than defined(__NR_fsopen). No suc=
h
> >> macro exists, so the guard is never true and the entire series compile=
s
> >> out. Guests calling any of the four get -ENOSYS, which for example mak=
es
> >> systemd's credential setup fail with EXIT_CREDENTIALS for most units.
> >>
> >> The strace bits for fsconfig() have the same typo.
> >
> > Please take a look at the following CI failure:
> >
> > ../linux-user/strace.c: In function =E2=80=98print_fsconfig_cmd_name=E2=
=80=99:
> > ../linux-user/strace.c:4352:10: error: =E2=80=98FSCONFIG_SET_FLAG=E2=80=
=99 undeclared
> > (first use in this function)
> > 4352 | case FSCONFIG_SET_FLAG:
> > | ^~~~~~~~~~~~~~~~~
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/15553379213#L2358
> >
> > Once this has been fixed, please send a v2 pull request. Thanks!
>
> I've sent a new pull request.
> I added a dependency on the availability of the FSCONFIG_SET_FLAG define.
> This is okay for now, but maybe a better fix is possible?
>
> Usually this define should be available, but it doesn't seem to
> be in that chroot image.
> I'm sure I'm missing something, but is it somewhere documented how to get=
 that chroot
> image locally so that I can reproduce the problem?

$ git grep build-without-default
.gitlab-ci.d/buildtest.yml:build-without-defaults:
$ cat .gitlab-ci.d/buildtest.yml
...
# Check our reduced build configurations
build-without-defaults:
  extends: .native_build_job_template
  needs:
    - job: amd64-centos9-container
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  variables:
    IMAGE: centos9
    ^^^^^^^^^^^^^^^^
$ git grep amd64-centos9-container
.gitlab-ci.d/container-core.yml:amd64-centos9-container

The amd64-centos9-container job builds the
tests/docker/dockerfiles/centos9.docker Dockerfile.

You can reproduce QEMU's centos9 image locally with `make docker-image-cent=
os9`.

Stefan

