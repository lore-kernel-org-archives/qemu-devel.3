Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE42C2A09B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 13:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsKc3-0001xz-Ap; Fri, 07 Aug 2026 09:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsKbx-0001qa-Lb
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:27:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wsKbw-0007kA-8j
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 09:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786109263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxB9g3gcR10AsGjPvS5NeCLX6mUzgiDeNqFWe4wgsSY=;
 b=LrVPRm8MfWk5jndEmipBDsWRP6w1VI5SG94e2v+Q9yAd4hsRgK1tmHP+lF4RKu4hmlTSr4
 KaYmsOwOwZRv14yCkXGoGgVpNDygZhpEqbZNn5SDbDcWbs60GPBPDwurpeHpiZhPqD3OKs
 aneQLF9Ep4oCnBK8j0HfPM4m+b6Qye8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-lYl-8FNxPjiZLFZt1RL0Vg-1; Fri,
 07 Aug 2026 09:27:42 -0400
X-MC-Unique: lYl-8FNxPjiZLFZt1RL0Vg-1
X-Mimecast-MFC-AGG-ID: lYl-8FNxPjiZLFZt1RL0Vg_1786109261
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 388B7180064F
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2026 13:27:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E17AC195DF93
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2026 13:27:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E1C421E6920; Fri, 07 Aug 2026 15:27:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/3] scripts/qapi: enum with conditional first item must
 be optional
In-Reply-To: <CABgObfbOVY5mpyhxQHOCvVDZkOHgTK=SmJ-gQ3A6_4Ywhhew_Q@mail.gmail.com>
 (Paolo Bonzini's message of "Fri, 7 Aug 2026 15:02:14 +0200")
References: <20260724130044.1369843-1-pbonzini@redhat.com>
 <20260724130044.1369843-2-pbonzini@redhat.com>
 <87a4rf61e9.fsf@pond.sub.org>
 <CABgObfaAnbH6eV3Gu305KjNBN9MCJN0TwPbbrE2ZkMWO4Mcxcg@mail.gmail.com>
 <87qzkozskq.fsf@pond.sub.org>
 <69be7bb2-cc30-4788-8bb5-6a6c51a65bb9@redhat.com>
 <87ldajwx5p.fsf@pond.sub.org>
 <CABgObfbOVY5mpyhxQHOCvVDZkOHgTK=SmJ-gQ3A6_4Ywhhew_Q@mail.gmail.com>
Date: Fri, 07 Aug 2026 15:27:38 +0200
Message-ID: <875x1moyb9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On Thu, Aug 6, 2026 at 9:01=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:

[...]

>> If forbidding empty enums makes Rust generation simpler or easier,
>> that's a compelling reason, isn't it?
>>
>> You should mention the Rust reason(s) in the commit message then.
>
> Rust can live with it.  I'm just taking a clue from the language.

No objection.

>> I might have banned conditional first members from the start if I had
>> thought out things back then.
>
> Ok, then let's do it.

Likewise.


