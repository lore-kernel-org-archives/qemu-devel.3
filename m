Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2092C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 07:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCZcn-0001Uq-2n; Wed, 07 May 2025 03:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCZck-0001UB-3L
 for qemu-devel@nongnu.org; Wed, 07 May 2025 03:55:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uCZci-0001lk-8l
 for qemu-devel@nongnu.org; Wed, 07 May 2025 03:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746604522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3TgzwexWi3Tl59TeP0/GgXQsKq/utGNxlw9hk6Zz2U=;
 b=I1rR1KITifPB9W+qIHioVo7EDg5eCS3Kq62n415A6Myf2Jm+tIsXQOZ6UUnekZc+J5ChJA
 JtbWbByV0Ouqx4ailwGQr2Ce9zSsL5jRjg/hBbcvg6MdUex83l35kod8zFJjJtWf53YycJ
 Zr4W0FKVW+Ij9/OUefINNE5AKGGO66E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-Zej7C2D4MsKrnun75S9e9A-1; Wed,
 07 May 2025 03:55:18 -0400
X-MC-Unique: Zej7C2D4MsKrnun75S9e9A-1
X-Mimecast-MFC-AGG-ID: Zej7C2D4MsKrnun75S9e9A_1746604517
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1A2F1800446; Wed,  7 May 2025 07:55:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D62119560A7; Wed,  7 May 2025 07:55:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ACAFB21E66C9; Wed, 07 May 2025 09:55:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 stefanha@redhat.com,  Michael Roth <michael.roth@amd.com>,
 pbonzini@redhat.com,  berrange@redhat.com,  peter.maydell@linaro.org,
 thuth@redhat.com,  jsnow@redhat.com,  philmd@linaro.org,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  devel@lists.libvirt.org,  Victor Toso
 <victortoso@redhat.com>
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
In-Reply-To: <f2972cb4-4266-4835-9548-706983dc611f@linaro.org> (Pierrick
 Bouvier's message of "Tue, 29 Apr 2025 12:15:39 -0700")
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org>
 <5b21965d-2428-454c-9dd7-266987495abd@linaro.org>
 <87a583789z.fsf@pond.sub.org>
 <25bb4527-f145-4d9c-8f91-a962bfa14a6f@linaro.org>
 <8734drpg4j.fsf@pond.sub.org>
 <f2972cb4-4266-4835-9548-706983dc611f@linaro.org>
Date: Wed, 07 May 2025 09:55:13 +0200
Message-ID: <87msbokg7y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

[...]

> I don't think we should think too much ahead for languages other than C,=
=20
> for one, two, and even three reasons :)

I agree that thinking ahead too much is a bad habit.  So is thinking
ahead too little :)

> - First, it's already broken because we rely on ifdef that won't be=20
> there in Rust or Go.

I don't think it's broken.  QAPI 'if' translates straightforwardly to C
#if, but that doesn't mean it cannot be translated to conditional
compilation / metaprogramming in other languages.

In fact, the value of 'if' used to be C constant expressions suitable
for use with #if, and we changed it to its current form specifically to
enable Rust work, in merge commit c83fcfaf8a5.  Marc-Andr=C3=A9's was trying
to develop Rust bindings back then, and if I remember correctly this
change was enough to let him implement 'if' with Rust.

> - Second, it's code, we can just change it later if needed.

True!

> - Third, those json are consumed only by QEMU (right?), so we are free=20
> to write/modify them as we want.

Also true.=20=20

> The only thing that must stay the same is what we expose to the consumer=
=20
> in the schema, and which commands we expose in qemu.

We may evolve the external interface as long as we honor our
compatibility promise.

You're aiming for "no change at all" there.  I understand why that's
desirable.  But if it should turn out that a bit of compatible change
simplifies the job, we can take the simpler route.

[...]


