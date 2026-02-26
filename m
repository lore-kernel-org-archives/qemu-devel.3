Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30429FCE07E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 13:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvbUJ-0005Dl-Gk; Thu, 26 Feb 2026 08:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvbUI-0005DY-1d
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 08:33:06 -0500
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvbUG-0001RJ-H5
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 08:33:05 -0500
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64ad8435f46so909793d50.1
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 05:33:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772112783; cv=none;
 d=google.com; s=arc-20240605;
 b=LiIIKupYlssQzeH3WZStnwwOFVJxtErdM3Ed2xh0/BT8PLUasUu0H7yw7sOeboDmFY
 VV5yAL1xBZaUe8cpAQoGp0OMWf4qjPfFH7BW5JwTzA5VlIc1N54/0az8+cLed8StcslN
 y8yUYVHUjahMmvXmc0fwOTnkVpuDsrH2HtB1adv9Jc2/2bU4Z8eKRdrrAjLKny5gMqZd
 WiJjMaVvUdDNd8Qfog4QyXIimDLWLRJAjM5PzC2JxcadCCbjUcqv6TmGh8NcTpj+vHpx
 P5HgYddGhd5mKekk+GHJePBsxpvIDMtJ4nP3/A94QpE5yazwN+LrpadC9YN89VuUHagS
 AsAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=emm+fOzlNK/3324ofA1rvajWn7CzXGKf8Ow+HEZmKf0=;
 fh=wZWECxj4up2f0ESeW7QI7zxzvm6aKp9CEoFhHVk4A0c=;
 b=CFTjaFsucDPvCykdnwhf2TMeYfe/6/efJEoS+tdzWoEvumTK/ThQjARcMle70B12bm
 U60ctQMSrQaiix93RT4b8zGj3Ra+97sa4UNaPsgZwNqMDxUqrWelTrnLcYHxq/RrBXeQ
 dlrufUq+n58v/MPAimVGAq3GgVh7u+/bR8ZChGxvagfbxugjZqz7P5lwy15vDxTkSIZ6
 4rOoen4wEgMs89d8KZKPuuE+MaNZR+zBQwiknBDSOlw4PH03YZ+zsKQNHidd3pM7FGQx
 U4KuGEjGzlvlKYyy4SvqIdzvvy0yqpfzo8779jgxCd+xO955tJ5dztML83zS1fXQdK9/
 o/0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772112783; x=1772717583; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=emm+fOzlNK/3324ofA1rvajWn7CzXGKf8Ow+HEZmKf0=;
 b=R/RB8c84imOFS2mKfwmBNqiscy76Hi8S5PsW2NqB2t6wjQ4VpNl7T30zdPxfABHevc
 +/EK5pgkQ9+ZYNCJt0d+s8S+8WHAf6jaJLphpOf0jic78LRuD8unVc3cR30jz/UnJdsL
 0H4P8ACt4VZXvOALSaMKMxWRrrgfM2JfcZ6t+oDDsiYsmKM1pAR8Gf8yUe8ZSnQlZ6Hz
 tW1r+S3wBHgKAhKiQ3kooheuCTCfldp/cQv8M4L+GvWlFxrzvx75h3LPf+ZAPx/6pDY+
 zMWzCuiiPn3fTN9EYixB79v59Mzjo/kndzQ4tUS/zbmElu65fRQCP4hU7kUIm/mONK61
 +M5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772112783; x=1772717583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emm+fOzlNK/3324ofA1rvajWn7CzXGKf8Ow+HEZmKf0=;
 b=VEHT6bPJTYCX/i9q/Ft6mKB0ZjMjth5BBboUn9ly7YAfgPPIZWgpXI2kNPItdWQx0f
 8uwwcKNXUN+e5vlGw74tBQ3O5vTkMPtmpxU3t1pVS0kHSld7b244ZJItIuqUj1Rr67Vg
 lZYgD88YBQUlYRXL4gT46ymqJ0j6oURYQUj4/UI3Ph4U5SfC2TVPwR3PipVRHV1m/mTI
 hcaNbN8syUacAtB+9IN0R8QGZC7+f2DcsyrzGBddVnGxQMKHxudVX65FUFBLmPO4rNpD
 79ko9ATXkAaRCSwE88v5v4jrwp/d/5SPRhOjAnbG+0rCGfOmB6Poynhec73fCUPMPvkh
 rU3w==
X-Gm-Message-State: AOJu0YzjwUwMnHIli6vt1qbGXwhW2vTN973c4nAScPj9+FxQrZIOQzEd
 NPr4VEs07fGYA12mQgml0jGg+xLK4QY9tlHlaheCQWzZoQy2rzBCVIKbwqWkr3JLdyCpExN4VZA
 nKwY+BEG3G4/6moImaQU/h1NiJ7Uhua4+Zc9QLdTJucr0yNbEmDhu0F8=
X-Gm-Gg: ATEYQzzItKSX+bbZ2TvlU+9NBQWhIPl/6d/8e9ldTEQgIsoMDuQWvkItcqt5GyR5iqE
 bMJXu4P1PxBDsRnonhqImjK832hssLtlkw09PSCynaVpxTmA9g8HRPFDtwGJlGAOKlPCkh2//IY
 tdMKSFxuLpqGPgLObFivUEt2AQ9x0HhiaHEONChG90VmxnyMH4WCgOESq1dAUh7c1MZxXcheYbQ
 rEa3hNNWjzP20LcrZrvattm3IPQgdeUSO5fVChVdVPbco74EO1jw4evULI6JBKSc09jEybOiW5E
 6bZzDLcbB2lTtaAjWohgC3tY8h80tckSBM/Qo/NuioIbIuvftrLF6y/tYB6vQRki4IMRMv5xbJ2
 AUg==
X-Received: by 2002:a05:690e:6cb:b0:64a:db34:8502 with SMTP id
 956f58d0204a3-64cb22db9d6mr2419705d50.13.1772112782909; Thu, 26 Feb 2026
 05:33:02 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Feb 2026 13:32:51 +0000
X-Gm-Features: AaiRm53u7J1Rgv2TBujn_pdfITKv1fb3EdKTvSw_vSJC9Z89BOdv3bBNuqGkzfs
Message-ID: <CAFEAcA-8as1Tc_N_hucAvUTi-O2ag9OHApY2j9Dq9=CO+A1wSQ@mail.gmail.com>
Subject: configure fails with "No matching distribution found for
 wheel>=0.34.2"
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On my local machine, configure now seems to fail with:

python determined to be '/usr/bin/python3'
python version: Python 3.12.3
mkvenv: Creating non-isolated virtual environment at 'pyvenv'
mkvenv: checking for meson>=3D1.5.0
mkvenv: checking for pycotap>=3D1.1.0
mkvenv: checking for qemu.qmp>=3D0.0.5
mkvenv: checking for setuptools>=3D44.1.1
mkvenv: checking for wheel>=3D0.34.2
mkvenv: checking for pip>=3D20.3.4
mkvenv: installing meson=3D=3D1.10.0, pycotap=3D=3D1.3.1, qemu.qmp=3D=3D0.0=
.5,
wheel>=3D0.34.2, pip>=3D20.3.4
ERROR: Could not find a version that satisfies the requirement
wheel>=3D0.34.2 (from versions: none)
ERROR: No matching distribution found for wheel>=3D0.34.2

*** Ouch! ***

Could not provide build dependency 'meson=3D=3D1.10.0':
 =E2=80=A2 Python package 'meson' version '1.3.2' was found, but isn't suit=
able.
 =E2=80=A2 No suitable version found in, or failed to install from
'/home/pm215/qemu/python/wheels'.
 =E2=80=A2 mkvenv was configured to operate offline and did not check PyPI.


This is on Ubuntu 24.04.4 LTS, and happens even if I delete
the build directory and configure from scratch.

Any suggestions?

thanks
-- PMM

