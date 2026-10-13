Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31EBCC6B0F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcju-0003yw-AF; Tue, 13 Oct 2026 09:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xGcjs-0003y5-AR
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:40:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xGcjn-0006sw-VI
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791898813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ixuHkfPyJqLvv2sMOAVZvLUfWTeU+sVf2M2BlGZCFt0=;
 b=R3ukLcBTWEeIs4R7BaCv5h4mSUke0W6GCUlWUxNY4h2X41HVHtGHUvhRo/UryCnw5ikdRY
 lv8LRf/k2I4YpwlN9Fm/1Mup1+paX6+06Agw0/o75SKPyh+DxAv8YlF9fcyiLAUB0aihIp
 rPJxUF0XIDMXsyWDHyIf3BdWr25GTKs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-vUVFzdz_OquXE0-i1AL2SQ-1; Tue,
 13 Oct 2026 13:40:08 +0000
X-MC-Unique: vUVFzdz_OquXE0-i1AL2SQ-1
X-Mimecast-MFC-AGG-ID: vUVFzdz_OquXE0-i1AL2SQ_1791898807
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10EB71828BB2; Tue, 13 Oct 2026 13:40:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC6181800446; Tue, 13 Oct 2026 13:40:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 52DD321E6A04; Tue, 13 Oct 2026 15:40:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  David Hildenbrand <david@kernel.org>,  Igor
 Mammedov <imammedo@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Jason Wang <jasowangio@gmail.com>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  kvm@vger.kernel.org
Subject: Re: [PATCH v5 15/62] qom: convert enum properties to QAPI-aware
 registration
In-Reply-To: <20260911-qom-qapi-v5-15-7732a55b7760@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Fri, 11 Sep 2026 20:34:49 +0400")
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
 <20260911-qom-qapi-v5-15-7732a55b7760@redhat.com>
Date: Tue, 13 Oct 2026 15:40:04 +0200
Message-ID: <87bj8xyb0r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Convert all callers of object_class_property_add_enum() to use the new
> object_class_property_add_qapi_enum() with the QAPI_ENUM_PROP()
> macro, which provides type information via QAPITypeInfo instead of
> raw lookup tables and string type names.
>
> This enables QMP introspection to report accurate QAPI type names
> for enum properties. Where a separate set_description call was used,
> the description is now embedded in the QAPI_ENUM_PROP initializer.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Fails qom-test for me:

    TAP version 14
    # random seed: R02Sae50f1988119a1a5ffa825624a2a4a56
    1..9
    # Start of x86_64 tests
    # Start of qom tests
    # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-13787=
95.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-1378795.qmp,=
id=3Dchar0 -object monitor-qmp,id=3Dqmp0,chardev=3Dchar0 -display none -aud=
io none -run-with exit-with-parent=3Don -machine none -object memory-backen=
d-ram,id=3Dnode0,size=3D65536  -accel qtest
    ok 1 /x86_64/qom/none
    # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-13787=
95.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-1378795.qmp,=
id=3Dchar0 -object monitor-qmp,id=3Dqmp0,chardev=3Dchar0 -display none -aud=
io none -run-with exit-with-parent=3Don -machine pc-i440fx-11.1 -object mem=
ory-backend-ram,id=3Dnode0,size=3D65536  -accel qtest
    qemu-system-x86_64: ../qom/qom-qmp-cmds.c:41: qom_property_info: Assert=
ion `prop->qapi_type->masked_name' failed.
    Broken pipe
    ../tests/qtest/libqtest.c:210: kill_qemu() detected QEMU death from sig=
nal 6 (Aborted) (core dumped)

PATCH 58 seems to fix it.


