Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEA2C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8nC-0008KE-6p; Mon, 28 Sep 2026 06:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xB8n0-0008Ci-EA
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:40:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xB8my-0004fj-Ur
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790592052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hc1EwtbYahY9c2Cug+ApRwdHvpNuhx3vsayoTvVcpxs=;
 b=cMOzVKIAW/etcoOmccgCgWx+V/NJYIMXm/1N/wfSZZ71ma8HIAfC/28v8wsHJyORtYDk1T
 alTbuy/0z0APFAsQMohpAQC9QekU3+WkS3t69TLFelqYcqmqNmKBTGCjhJx4/0KbO0+lRH
 wLUd0gw0RuybZdZGzKZLC7LiXIdKZIs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-KYvgagZXNbqDk5ZCTUiCPg-1; Mon,
 28 Sep 2026 06:40:47 -0400
X-MC-Unique: KYvgagZXNbqDk5ZCTUiCPg-1
X-Mimecast-MFC-AGG-ID: KYvgagZXNbqDk5ZCTUiCPg_1790592045
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E990195D021; Mon, 28 Sep 2026 10:40:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8576F30000E4; Mon, 28 Sep 2026 10:40:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0BB6421E6A04; Mon, 28 Sep 2026 12:40:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Alistair Francis <alistair@alistair23.me>,  Peter
 Maydell <peter.maydell@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-arm@nongnu.org,  kvm@vger.kernel.org
Subject: Re: [PATCH v4 31/55] accel/tcg: move memory helpers out of
 tcg-runtime.h
In-Reply-To: <20260926070057.1234-32-luoyonggang@gmail.com> (Yonggang Luo's
 message of "Sat, 26 Sep 2026 15:00:30 +0800")
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-32-luoyonggang@gmail.com>
Date: Mon, 28 Sep 2026 12:40:41 +0200
Message-ID: <87cxtxhd5i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Yonggang Luo <luoyonggang@gmail.com> writes:

> memset, ld_i128, and st_i128 are declared in ldst_common.h, and
> ldst_common.c.inc emits their helper info. Atomic helpers move to
> atomic_common.h, with info records emitted from atomic_common.c.inc.
> tcg-runtime.h keeps the integer helpers implemented in tcg-runtime.c.
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>

Another compilation failure:

    cc -m64  -o tests/unit/test-tcg-call-tl libevent-loop-base.a.p/event-lo=
op-base.c.o libqom.a.p/qom_container.c.o libqom.a.p/qom_object.c.o libqom.a=
.p/qom_object_interfaces.c.o libqom.a.p/qom_qom-qobject.c.o libqom.a.p/qom_=
compat-properties.c.o libqom.a.p/target-info.c.o libqom.a.p/target-kconfig.=
c.o libsystem.a.p/accel_tcg_tcg-runtime.c.o libsystem.a.p/tcg_optimize.c.o =
libsystem.a.p/tcg_region.c.o libsystem.a.p/tcg_tcg.c.o libsystem.a.p/tcg_tc=
g-common.c.o libsystem.a.p/tcg_tcg-op.c.o libsystem.a.p/tcg_tcg-op-vec.c.o =
libsystem.a.p/tcg_perf.c.o tests/unit/test-tcg-call-tl.p/test-tcg-call-tl.c=
.o tests/unit/test-tcg-call-tl.p/test-tcg-call-tl-stubs.c.o tests/unit/test=
-tcg-call-tl.p/.._.._page-vary-common.c.o -Wl,--as-needed -Wl,--no-undefine=
d -pie -fstack-protector-strong -Wl,-z,relro -Wl,-z,now -Wl,--start-group l=
ibqemuutil.a subprojects/libvhost-user/libvhost-user-glib.a subprojects/lib=
vhost-user/libvhost-user.a -lnuma /usr/lib64/liburing.so /usr/lib64/libgio-=
2.0.so /usr/lib64/libgobject-2.0.so /usr/lib64/libglib-2.0.so /usr/lib64/li=
bgmodule-2.0.so -pthread /usr/lib64/libgnutls.so -lm /usr/lib64/libpixman-1=
.so /usr/lib64/libepoxy.so -Wl,--end-group
    /usr/bin/ld: libsystem.a.p/tcg_perf.c.o: in function `perf_report_code':
    /work/armbru/qemu/bld/../tcg/perf.c:328:(.text+0x5e9): undefined refere=
nce to `debuginfo_lock'
    /usr/bin/ld: /work/armbru/qemu/bld/../tcg/perf.c:341:(.text+0x66f): und=
efined reference to `debuginfo_query'
    /usr/bin/ld: /work/armbru/qemu/bld/../tcg/perf.c:361:(.text+0xa91): und=
efined reference to `debuginfo_unlock'
    collect2: error: ld returned 1 exit status


