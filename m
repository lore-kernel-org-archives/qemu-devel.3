Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12CDC5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 17:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyYoC-0004q1-6m; Mon, 24 Aug 2026 13:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyYoA-0004pm-10
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 13:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyYo8-0003oe-Cr
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 13:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787593803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cx52+k5Q2adnygbcGYH2swd951C1XDW7YFLy05W/I/c=;
 b=TurAo9fcvumY0zFZPWHcnfes0OM8eRnbln/Bq86XFGqU/DBOGcVRQTu+KShmqYxcIZPKiC
 Zav9mFHEjUtYG5stowrFuQmBSEoqhhWtMJphRfetglzlFLXzK94t5mvaPwTTpPkWPQpnaj
 aSIB5cCM5u6YwSaN+bFVA5zBCEPH2R8=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-Uir_N_z5MZWgHSwwnRDppQ-1; Mon, 24 Aug 2026 13:50:01 -0400
X-MC-Unique: Uir_N_z5MZWgHSwwnRDppQ-1
X-Mimecast-MFC-AGG-ID: Uir_N_z5MZWgHSwwnRDppQ_1787593801
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66c70d28b78so10801795d50.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 10:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787593801; cv=none;
 d=google.com; s=arc-20260327;
 b=VYWV9zGPkFfur60k6WB5F2hIY+lwAvE4kTu3vkIGYFpomZbOOBJFxvlK7v+q8JfaHp
 eSsrAPjigBajMxx7Rq2TWgjCVs+MsMOrQ6agFpQZS+nnVkAl2dV+556u6l7CXG4ezawc
 Dz885KadRl2dJT9z0JdQRWMZ0rG2f3qM3BjMpc5W48ECeJRJhrw9KnAc11Hu3kB9oaTU
 xRzTJ8cBoiD1dkEoIcclXCvlCg0tygZRQp8K4r1+bPRJwt4jhyBQMiZHBdXsSZkPE/E5
 SMMwfK56yhJZCNzw3+2JW4CTbb8DfbE5vjZfbT4oKdzrfrXsmsH0gaGSrwRA60bCkeWq
 WREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=Cx52+k5Q2adnygbcGYH2swd951C1XDW7YFLy05W/I/c=;
 fh=IJ+l1NUJ5XzampO9wi7a6Tzad3qtH2Cg4J2Ba+zvQCw=;
 b=kDRN7OPdsrLnTh+ohjX0zs5gE9KGe3vmlq4fhAirCb4JemInFHVLX9/v52nunSJlnV
 sF3urGpVbppn1xq2j55UzkYGeSH+w9+txX5XTu37hLGJVDehkQMXKbvI5DJ5d6xA4LDw
 oK7zZbvINwR3G17kS/XZZzCMTJFtJeMit0RgZztMjYWj9Uf5iXa4Mo6jzpsOff39Cggz
 kzmzhvhVGa2nK571lmOXdX4d2oy4aTZbyXZX100j0dv69R6Ht0vWjizHvpyQDnqEDS/C
 KWiZTEMzaSBqyJ7V+EXmoX6IkIUbIoDXb/3W9Sq/raXzbZtKYQ6UshSBOZpMJQnFEN/D
 UcXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787593801; x=1788198601; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Cx52+k5Q2adnygbcGYH2swd951C1XDW7YFLy05W/I/c=;
 b=GVSZjMZuYtbK5Oy+paeLx58TdiQUvODGIepxfKycIlnphS7krZfPjjQYDkoyL/f6I0
 q/SRIxrmsl9sl7fOeqOEYJ3MATHHArqmj+sD4lhP9ApMLK3PSIx22spp+aUWA7Uob5xQ
 pzZvMoLgh+te3u+JIDlI3iAHpZ9rRpKsjJTV+l6+Ma0+LvfWF+NKawlP6slpZlAE9Tpn
 jbDx7pmi7pTen8Adldc+eCbpNYRqfvVisv/MdkDl50uMVDSoKagHZvQ4+PFDe+Msea4Y
 6zJoA2KhAUI125p3GHFotx8oEmx8+WAK9ZDQmCBfHg37XBpNBFxhCimQTFAFkY/M2fbm
 eblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787593801; x=1788198601;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Cx52+k5Q2adnygbcGYH2swd951C1XDW7YFLy05W/I/c=;
 b=Q9R2j2fpArsBF3Vz2TuDrVUExp8tZhnvH+tH8GeCrrmrTGS6WvIS9e4og3DBmBNNwn
 WC7vmC2IntFi+dccKM25BT166PDZM+VLqpo8Limy6JmMD+VnASQGTP43rdPrD6wLDT0w
 7noqyo7ZxjBd5LK2yATRnNSXdHJQ73SMPt8O24up3fdCCMk/hTRGSHEeHAz12cUVyLJs
 Ceu6ApuL8/1D6o/o752MT0Y6PgJcpOcXUdUP/kg0Vmtwoo7M+serUlJl6TuhgrCbzemM
 o5nGSzJn7KspKWI88Z0gv1M6tNOYcnlyp/LHJy/UR0n5ESYrUMIdqmGbBkVNYYuwwK98
 3M0Q==
X-Gm-Message-State: AFuF++lqAdv3uCPIiJXik4IshzyzY2vQ0MLv2Hm7itx+5TMNrH077gaP
 iKn88K+56xch8s97ViOQjE0OpElh0v0YzodIBMyEJWNOiW8xW9WQvGHBNVHd1a+FlQ/mKtM1Nuf
 rI4ILhSF6bmZLxStLpBGIvbdxG+UWRtV7eNBV8WT7HSq8l4Ja38zNTxNmPhfSMtj1jLgu1rswx+
 gWqXlsJvh3iwIyNqN2rKDKgF5jhtjyhZI=
X-Gm-Gg: AR+sD10Aijo3kCsBrVsXy5So20TeVPxSuq3gSeXmRRir5Qh2lMVWPBHq0RuGx2wUCTG
 LkaVD6PMB6c4X6O/7EUZRpqzh/mdojOlKzj9H4csdMANg+ClI+omM8xACUEYWEFxLqJyKOqGKW2
 ZUH+tN2Z5hQQJVG3GqehPRrF3jolyDgi5NOx7GfzdQ4EQ9K5bEzPhlbWeSlLeTsrj8WDsVjMG1k
 YMxRgTqiXeizGZE
X-Received: by 2002:a53:e029:0:b0:66c:990e:5e3c with SMTP id
 956f58d0204a3-66ce4a07e8fmr7506807d50.13.1787593800806; 
 Mon, 24 Aug 2026 10:50:00 -0700 (PDT)
X-Received: by 2002:a53:e029:0:b0:66c:990e:5e3c with SMTP id
 956f58d0204a3-66ce4a07e8fmr7506792d50.13.1787593800289; Mon, 24 Aug 2026
 10:50:00 -0700 (PDT)
MIME-Version: 1.0
From: John Snow <jsnow@redhat.com>
Date: Mon, 24 Aug 2026 13:49:49 -0400
X-Gm-Features: AcwNN1XMPEPb5yZ2Bg5sMFMi2cWxD8ctY0EpO4GVk51NF4JUztMJ9sv_rUFzWR8
Message-ID: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
Subject: IDE failures under netbsd unit tests
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

Heya Denis;

In the process of upgrading Python to 3.12, I found that our netbsd
tests were a little broken - I will post patches soon - but if you add
"bison" to the list of deps in the netbsd vm test file, you can get
far enough to see this:

=E2=96=B6  163/1096 ERROR:../src/tests/qtest/ide-test.c:1260:main: assertio=
n
failed: (ret =3D=3D 0)     ERROR
 163/1096 qtest+qtest-i386 - qemu:qtest-i386/ide-test
                     ERROR            0.01s   killed by signal 6
SIGABRT
>>> G_TEST_DBUS_DAEMON=3D/home/qemu/qemu-test.kgtky7/src/tests/dbus-daemon.=
sh ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1 MA=
LLOC_PERTURB_=3D224 UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:pr=
int_summary=3D1:print_stacktrace=3D1 QTEST_QEMU_BINARY=3D./qemu-system-i386=
 PYTHON=3D/home/qemu/qemu-test.kgtky7/build/pyvenv/bin/python3.13 QTEST_QEM=
U_IMG=3D./qemu-img MESON_TEST_ITERATION=3D1 MSAN_OPTIONS=3Dhalt_on_error=3D=
1:abort_on_error=3D1:print_summary=3D1:print_stacktrace=3D1 RUST_BACKTRACE=
=3D1 /home/qemu/qemu-test.kgtky7/build/tests/qtest/ide-test --tap -k

Maybe something that cropped up due to recent changes? I am not sure,
but figured I'd give you a heads up.

--js


