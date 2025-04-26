Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF44C369CB
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Apr 2025 04:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8XXd-0000dn-Cs; Sat, 26 Apr 2025 00:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u8XXc-0000dJ-40
 for qemu-devel@nongnu.org; Sat, 26 Apr 2025 00:53:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u8XXZ-0005DW-JN
 for qemu-devel@nongnu.org; Sat, 26 Apr 2025 00:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745643202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Bz7MNYWl7Dr5aaNKwvQ4DMcfjkctfYwL/0or97pXhM=;
 b=AQs2Po1haLies67/eRydWmp6CYWIgBSSz08xcnzE0uHsSlm6kjOECU+HA7rZ4NEmK8CpvC
 M1FMyOuricY8t0aFJripj98FdIEeWZx/CaNptr/F4IrHM3+OMghfDGTN8879jJjEJ5v6ua
 HMRkvb41orehzsdQ46+lAvA3whpiLz4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-CSI5szHyOMavDobK8Z03-A-1; Sat,
 26 Apr 2025 00:53:16 -0400
X-MC-Unique: CSI5szHyOMavDobK8Z03-A-1
X-Mimecast-MFC-AGG-ID: CSI5szHyOMavDobK8Z03-A_1745643195
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C88C31800446; Sat, 26 Apr 2025 04:53:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.5])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 230F41956094; Sat, 26 Apr 2025 04:53:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A8EF221E6768; Sat, 26 Apr 2025 06:53:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 richard.henderson@linaro.org,  stefanha@redhat.com,  Michael Roth
 <michael.roth@amd.com>,  pbonzini@redhat.com,  peter.maydell@linaro.org,
 thuth@redhat.com,  jsnow@redhat.com,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
In-Reply-To: <305d68df-b690-4a93-9a08-925cddbac8e3@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sat, 26 Apr 2025 00:16:03
 +0200")
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <aAs6Q2GiBUbUCc2I@redhat.com>
 <305d68df-b690-4a93-9a08-925cddbac8e3@linaro.org>
Date: Sat, 26 Apr 2025 06:53:11 +0200
Message-ID: <87wmb78qx4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 25/4/25 09:35, Daniel P. Berrang=C3=A9 wrote:
>> On Thu, Apr 24, 2025 at 11:33:47AM -0700, Pierrick Bouvier wrote:
>>> Feedback
>>> =3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> The goal of this series is to be spark a conversation around following =
topics:
>>>
>>> - Would you be open to such an approach? (expose all code, and restrict=
 commands
>>>    registered at runtime only for specific targets)
>> QMP defines a public API between QEMU and external mgmt apps, and person=
ally I
>> like the idea that the API exposed is identical across all binaries and =
thus
>> the API becomes independent of the impl choice of combined vs separate b=
inaries,.
>
> I tried to expose all structures / unions as a first step (not yet
> commands) but realized even structure fields can be conditional,

Correct.  See docs/devel/qapi-code-gen.rst section "Configuring the
schema".

> see @deprecated-props:
>
>   ##
>   # @CpuModelExpansionInfo:
>   #
>   # The result of a cpu model expansion.
>   #
>   # @model: the expanded CpuModelInfo.
>   #
>   # @deprecated-props: a list of properties that are flagged as
>   #     deprecated by the CPU vendor.  The list depends on the
>   #     CpuModelExpansionType: "static" properties are a subset of the
>   #     enabled-properties for the expanded model; "full" properties are
>   #     a set of properties that are deprecated across all models for
>   #     the architecture.  (since: 9.1).
>   #
>   # Since: 2.8
>   ##
>   { 'struct': 'CpuModelExpansionInfo',
>     'data': { 'model': 'CpuModelInfo',
>               'deprecated-props' : { 'type': ['str'],
>                                      'if': 'TARGET_S390X' } },
>     'if': { 'any': [ 'TARGET_S390X',
>                      'TARGET_I386',
>                      'TARGET_ARM',
>                      'TARGET_LOONGARCH64',
>                      'TARGET_RISCV' ] } }


