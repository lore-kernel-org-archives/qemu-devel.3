Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D01CC6B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 00:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGnFu-00078S-VJ; Tue, 13 Oct 2026 20:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGnFs-00077T-A8
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:54:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xGnFq-0004Jy-5B
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 20:54:04 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DKGjkX442764
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tT8fHw8GqlE
 EjvdhQeN4T5ab6ZoZVUWORJJE3Dgv64A=; b=Zdq3K/ydN9Ur++heI0yrVOK/9ED
 GLZgQWSOeEqn5jgxBs389cP74ipEFXJ9aPJtovYGvf2hWb4ny76C7r4jrkH9JnR2
 4VC/2pdoGCDlmgR8tIDht/nUHKSqVPHUWeSWmxlA6Mj1T5Itvs9kXTbXGzxvlZBT
 J4gZNq22DzjoJpyWTP1FubSKchc467134ESST2OgOi67mXMqm9sNS4LfE9YElkx4
 yErro4Jscz4z5l6WXyGuyUE8gloPOLvc8+16kHX9AFqoOMVxoBwfo1qt9eTjh1+T
 bK4WXFxXxpB4XkXh0OJnTd+cgvDyxxuo0OyzY4QhJbsiBwxW3YERnpxHRGA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9n71juux-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:54:00 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35cbea41088so704871eec.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 17:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791939239; x=1792544039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tT8fHw8GqlEEjvdhQeN4T5ab6ZoZVUWORJJE3Dgv64A=;
 b=aO83qMkNO1VmBQVvKcUQa7tYUzlzMTpOCELP/ROlLD7d/D5bkbm8Mv8WEgbexxKGuX
 6c312Ov/GB+c0tJ8ZufYkiuGccLG9kbpeSZUPkRMk9GgOdWNcWojwhOWHE/umKYEIAex
 pfn0BDlR90r4QnpuncHe6FWJB2aIoDHG2tc8vjTwj51dU7Ff6bL/DgMVVp1TFyFYC4Ny
 AipndJHh9OqJ24Yv4Bx6lcxhvPVL5O3KIH3ZxJL0Zr5gMkqPH9zFEgrEUhUWbGiF6B41
 HY/qGJ9NhIozBxpDd+SSKyCc3k5U5ZhI865jKx8V9Nve4KFvn10SUD5rF94sSlu0Ex0L
 CapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791939239; x=1792544039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tT8fHw8GqlEEjvdhQeN4T5ab6ZoZVUWORJJE3Dgv64A=;
 b=PTGIWUsOU7UbN6Meds9lsTR2w9ebm0mUajfZcjob53yhtGRxHsPQp+GcIkUOKpvYgD
 s5KgAvhqLK0G1ZTKprfDK3AveJP1jx3P47w+F8cjx3l7oUisTS9Mx9GUCCupok3AVQtF
 6h4/FtSjFvWD9al7rvUZ4WURs8io0fSO5Z8cYaSGYjU7HrAePjFxBUQssrVb8QudCtNZ
 EhlCW9TIU9xgex5RNPF7ivypKhgTRZ/3AE3ZLvLl2+QGjnNnkLMqYhty3wPfiSU6KCTL
 1aIUzF4bIZSUOitKou+evsr5TK8GC53xI15PgSiLJmn44IU9+Sp9BI2NF+VWrGYM52I9
 7QQw==
X-Gm-Message-State: AFq9FYLLsQV6+NmRZqhW7UToUc5CHmm6kxoWpygTWHx5npbt/rFK6t/O
 I1+S/x9cQ7xMW3750x/cXvVnXJIPZkRhv3Bq/QlvM34mciKAlpyMXXBqHqj9IiR/wng3oFkQvEY
 whnc7UP4c6aoKvk8EOUfs9rSj0M7DAbs2Nu/NUbaF+5MISk6N9eZ+si/2/OrukOhY2g==
X-Gm-Gg: AYBFou17zZJTQ5HFY8SL37Ea+fkeQBV16TVpOJ1tD6icXh7Xtrdtvce+fZhxw+9Zfpe
 vYSVZjrmcmuaenWK7auhz4AUeqP+t4i1LaBHJjIkeAqMhBTS5/wTzbkbfqQT2OJB7bHb/QTa8on
 z+MdeBv7jOu3DXdmzyZfcvXW+XLTdsnc7dw0yoSwDdIog0FCPXSUuOoR9M2A4nATRwlglQR+xyE
 qFkwZdWZ8Zt/D/YGFionYqF5YEzlyiKS+YZM5iVDYcgTbHvZdlROR0MwsyqHQ5Z+pSGcc+aFfdx
 SAxFmO/myL9N5zUP8MEBPk2Rz2UU0s1Lnn70b2+ZdcdmwaIw/cXFzVk3+uf1jBoxCzslrEb0CjZ
 pxSm3Aa4COGuYcarDMDHrtFdigaLDyHtejYcthC/Ubss+Djz+HCRHPyGDO8Up
X-Received: by 2002:a05:7300:b2a0:b0:35d:a0cd:d51f with SMTP id
 5a478bee46e88-35da0cde46bmr1245205eec.23.1791939239326; 
 Tue, 13 Oct 2026 17:53:59 -0700 (PDT)
X-Received: by 2002:a05:7300:b2a0:b0:35d:a0cd:d51f with SMTP id
 5a478bee46e88-35da0cde46bmr1245160eec.23.1791939238627; 
 Tue, 13 Oct 2026 17:53:58 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-359789fde97sm31823564eec.20.2026.10.13.17.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 17:53:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 mjt@tls.msk.ru, peterx@redhat.com, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 1/3] tests/docker/dockerfiles: add release.docker
Date: Wed, 14 Oct 2026 00:53:36 +0000
Message-ID: <20261014005338.34657-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014005338.34657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FuqQbGrq c=1 sm=1 tr=0 ts=6aced2a8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=fxJcL_dCAAAA:8
 a=p0WdMEafAAAA:8 a=ID6ng7r3AAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=DfNHnWVPAAAA:8 a=GUVi8RmzAAAA:8 a=4HQkHWYM07Omh7VlaF4A:9
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=AkheI1RvQwOzcTXhi5f4:22 a=rjTVMONInIDnV1a_A2c_:22
 a=jSdgSmmMQx7r16_JUfbt:22
X-Proofpoint-GUID: F2OwuI9QThmm9pyU-1T7zRsQmr0jzRzf
X-Proofpoint-ORIG-GUID: F2OwuI9QThmm9pyU-1T7zRsQmr0jzRzf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAwMyBTYWx0ZWRfX/3QE8vyHYAbf
 DkFjtmLKKs215NYGgdXqVtj4K/mgp8OD4KchyIuAfCcfEzfBhCRTPlYOZg4U9lQV+eyFlsTSWN3
 S/b4lNLV7raUGZs+q0ATtP+HOaIRp+hlwlu+CP1w1MzEepX0blaL1JiP6FHOCszAfhp/3YTELv1
 iJJpOx60A5AUl5Wz5vIi6ixN6c67PIpUtDfwwTDfFbWTDm3ZMzqpIlMNY4wWwuYyPqbP4wcAtbk
 55F77UqJzARgDsRRKatogy/5DpwAgLfWRWAJ1nAwxycoeTSodG2JERYuMdyIJPfGD+Wryqo4Fod
 ijJtEeC5UlpmOHpyr/vvH/m4EgQxMNocQXuc8Cj12WWHSw+kYP8XMSN/LD21WYu0Qt4OCKWa3lg
 LbD+pc5+HNbP5nweIptbIqnvHxsGA4qYz9GVP8WvSnxnrf4vdVfdjHDWnVVqntn6DRa1SQmG91a
 e03dofdYecu08/j6Z8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAwMyBTYWx0ZWRfX10ODLI9kVvai
 cxrPtZwuBU3ZGcOB5APhKtfkM5hZH22GJ+clECmYW0ysEOzZcEBJUkhhT4Hwvgmbt4EJi9gMIw5
 9bx3vUftfYnw1cbAZxdeEvF/T9Cn9q0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140003
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

This new dockerfile allows to build a distroless image containing only
qemu stripped release binaries, their lib dependencies, and installed
artifacts (roms, keymap, ...). There is no shell, no python, nothing
else. This is achieved thanks to a multi-stage build, where we add qemu
binaries, artifacts and libraries in a new scratch image. Image has
the minimal size possible.

This is based on Ubuntu, which has the advantage to have working
containers available up to 12.04. Debian old old stable have broken apt
sources for instance. Ubuntu 10.04 binaries segfault due to missing
vsyscall emulation on modern kernels, so 12.04 is the lowest possible.

This unique dockerfile works for all qemu versions, with 0.12.0 being the
oldest we can build today (based on ubuntu 12.04). Previous ones need an
older compiler.

To build the image, you need to provide a qemu and ubuntu version:
$ podman build -f release.Dockerfile --build-arg QEMU_VERSION=v11.1.0 --build-arg UBUNTU_VERSION=24.04 -t qemu/v11.1.0

To run it, as there is no shell, and no defined entrypoint, you need to
choose the binary you want explicitely:
$ podman run -it --rm qemu/v11.1.0 qemu-system-aarch64 --version

Notes: We could optimize a bit further, by creating a base container for
each ubuntu version, that is reused between all qemu versions built with
it. Given that recent QEMU have around 800MB of binaries + artifacts,
and only 100MB of library dependency, I don't think it's worth the extra
complexity.

Notes: Also, I considered create one image per binary. Problem is
that qemu depends on other artifacts (rom, keymap, etc) and it's not
easy to identify what is needed for one binary. Thus, I think it's
better to stick to one container with all binaries per release.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/release.docker | 76 +++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 tests/docker/dockerfiles/release.docker

diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/dockerfiles/release.docker
new file mode 100644
index 00000000000..611ecca9859
--- /dev/null
+++ b/tests/docker/dockerfiles/release.docker
@@ -0,0 +1,76 @@
+ARG UBUNTU_VERSION="UBUNTU_VERSION_build_arg_must_be_set"
+FROM ubuntu:$UBUNTU_VERSION as build
+ARG UBUNTU_VERSION
+
+# add deb-src for apt build-dep
+RUN sed -e 's/Types: deb/Types: deb deb-src/' -i /etc/apt/sources.list.d/* || true
+RUN sed -e 's/# deb-src/deb-src/' -i /etc/apt/sources.list
+# archive.canonical.com is not reachable anymore, and cause a long timeout
+RUN sed -e '/archive.canonical.com/d' -i /etc/apt/sources.list
+# LTS < 14.04 are hosted on https://old-releases.ubuntu.com/releases/
+RUN if [ $(echo $UBUNTU_VERSION | cut -f 1 -d '.') -lt 14 ]; then \
+    sed -e 's/archive/old-releases/g' -i /etc/apt/sources.list; \
+fi
+
+# use apt-get since apt was missing -y option in some ancient distro
+RUN apt-get update && \
+env DEBIAN_FRONTEND=noninteractive apt-get install -y git build-essential
+RUN apt-get update && \
+env DEBIAN_FRONTEND=noninteractive apt-get build-dep -y --arch-only qemu
+# additional dependencies that are missing at some point in history
+RUN apt-get update && \
+env DEBIAN_FRONTEND=noninteractive apt-get install -y ninja-build flex bison libpixman-1-dev
+# python3-venv didn't exist in ancient ubuntu distro
+RUN apt-get update && \
+if apt-cache show python3-venv; then \
+    env DEBIAN_FRONTEND=noninteractive apt-get install -y python3-venv; \
+fi
+
+# patch cc and c++ to inject warning suppression options
+RUN mv /usr/bin/cc /usr/bin/cc.real
+RUN echo "#!/usr/bin/env bash" > /usr/bin/cc && \
+echo "exec /usr/bin/cc.real \"\$@\" -Wno-error -Wno-int-conversion" >> /usr/bin/cc && \
+chmod +x /usr/bin/cc
+RUN mv /usr/bin/c++ /usr/bin/c++.real
+RUN echo "#!/usr/bin/env bash" > /usr/bin/c++ && \
+echo "exec /usr/bin/c++.real \"\$@\" -Wno-error -Wno-int-conversion" >> /usr/bin/c++ && \
+chmod +x /usr/bin/c++
+
+# 2.9.0 => 3.1.0: clone git submodules from expired url, replace them with gitlab.
+# 2.9.0 => 2.11.0: issue with libfdt version, solved with dtc submodule, which
+#                  was removed later.
+# Ubuntu < 14.04: git has no --single-branch, so perform manual fetch after clone.
+ARG QEMU_VERSION
+RUN echo "QEMU_VERSION=${QEMU_VERSION:?QEMU_VERSION build arg must be set}"
+RUN cd /tmp && \
+git clone https://gitlab.com/qemu-project/qemu.git --depth 1 && cd qemu && \
+git fetch origin "${QEMU_VERSION}" --depth 1 && \
+git checkout FETCH_HEAD && \
+sed -e 's#git://git.qemu.org#https://gitlab.com/qemu-project/#' -i .gitmodules && \
+sed -e 's#git://git.qemu-project.org#https://gitlab.com/qemu-project/#' -i .gitmodules && \
+sed -e 's#https://git.qemu.org/git/#https://gitlab.com/qemu-project/#' -i .gitmodules && \
+sed -e 's#git://github.com#https://github.com#' -i .gitmodules && \
+if grep -q dtc .gitmodules; then git submodule update --init dtc; fi && \
+./configure --prefix=/opt/qemu --disable-docs && \
+make install -j $(nproc) && \
+strip /opt/qemu/bin/* && \
+rm -rf /tmp/*
+
+# retrieve runtime dependencies (libs + loader)
+RUN ldd /opt/qemu/bin/* | grep '=>' | sed -e 's/.*=>//' -e 's/(.*//' | sort -u > /opt/qemu/libs.links
+RUN find /lib*/ld-linux* >> /opt/qemu/libs.links
+RUN cat /opt/qemu/libs.links | xargs -n1 readlink -f > /opt/qemu/libs.realpath
+# store them in /deps
+RUN mkdir /deps && cp --parents $(cat /opt/qemu/libs.*) /deps/
+
+################################################################################
+FROM scratch
+
+# copy qemu and all associated artifacts (roms, ...)
+COPY --from=build /opt/qemu /usr
+COPY --from=build /deps /
+
+# build with:
+# podman build -f release.docker --build-arg QEMU_VERSION=v11.1.0 --build-arg UBUNTU_VERSION=24.04 -t qemu/v11.1.0
+# run with:
+# podman run -it --rm qemu/v11.1.0 qemu-system-aarch64 --version
-- 
2.43.0


