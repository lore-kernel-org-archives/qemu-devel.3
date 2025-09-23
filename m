Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AE2CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1040-0000Ef-6I; Tue, 23 Sep 2025 06:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v103t-0000BK-R6
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:15:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v103p-0002gX-0g
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758622541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J3dtymLCg/6j+HdSyY2YbJ5VKtwSZF/kCGLsnyaf/zk=;
 b=WHXWiEq27p93c5aec3GcV+KfLaHfz/Y877bwJZfPisU3GTkg6CD/HXTupK2tm0ePFaTntv
 W0ecZIVpOO12w4fb+mbFsRXJtBvxdGR+oMzF9buQlTwEQQYHhrA31eLYhQZ+Gm4rkGXoDH
 GbyvrOYdtB5VIOmFNwN0PcTxXHfd44c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-AgE3-AK1O6evozVA4G4FpA-1; Tue, 23 Sep 2025 06:15:39 -0400
X-MC-Unique: AgE3-AK1O6evozVA4G4FpA-1
X-Mimecast-MFC-AGG-ID: AgE3-AK1O6evozVA4G4FpA_1758622539
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ee1317b132so1134118f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 03:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758622538; x=1759227338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J3dtymLCg/6j+HdSyY2YbJ5VKtwSZF/kCGLsnyaf/zk=;
 b=d6u3jbETk7MATjBhM2TbPijBiWx9TxlPpOCW6RzAe3T4I4S4Zcnw/v002ESBYchtsT
 VP6k+B2hZB1cB7sU8/a6R7XwhT4QFf/QNDPnu9kiWdavo6Manib+OhiaHOaEMypFLmv7
 KrdovPFUknZQI/6umSTclST/vMIuQg9uBPx/SrzUXqWZf2AxN7ohDzFiKs8wcpqOc+gD
 8WprCjxVQJGM+gJbaxyLok7NRFK//jyVx2l1cLei3hPWxZgkg0teM3LskjdVD+gmMTjv
 BfdnA1r+X8DgEwi0mNiwchC4p0MEmG1u4av96qn3TwBRjTU4yXSJNyX+OtOg6X1XRQPX
 bdfg==
X-Gm-Message-State: AOJu0YxO+Qid2gzHAFrs5uGED0g9oPzq2IBAQ+B9YVa0J4I3KG+GAg1n
 bz7M7n/6vEyFuExm4loarN8dO/q7BCcVn7AucwQtQ5ECYtYknFAnAewtjUVb4dUc3SzvTmFdMpw
 0apKqB0EGGoqF+Sju2I8+9qkROu+m7tU+kQiINps4QfRCa+6tXJ/9Y0w9jItFh04slQdwIxuh9t
 5adCeT/evIAWihj/R5hhg8cEIZ5tZM3G0=
X-Gm-Gg: ASbGncukncASJSdzubvgXlBMQA3RbeSX8y5TSJb06jIZ8+wgaoFEwVxOH9PKxNXG67A
 QfIaG80ErGYmoZR3Pv55EUZM86005/0D1qCdWAKKHNJzvIMI2ppROVv0q86vljQBiHoppgEoBhP
 aWS7tOXTt+eoXLB6y+STnp4aKAGLT737DcXorTPqNvQ6DjZ3lcu6vvpVM3HTrVUnr1WJjNsBh0R
 WjIUhAemXUtgtDGVTu70/LNg+o=
X-Received: by 2002:a05:6000:2285:b0:3ff:8c59:3609 with SMTP id
 ffacd0b85a97d-405caa503d7mr2006096f8f.38.1758622538561; 
 Tue, 23 Sep 2025 03:15:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2ji/8xuujTDcntwe1sfLX6Kcx/s3AcPeMYN9yhZwj4+h3YmrULxLM1YnbYhYf/Jv/zE/KYfMHJH/wT0KJsow=
X-Received: by 2002:a05:6000:2285:b0:3ff:8c59:3609 with SMTP id
 ffacd0b85a97d-405caa503d7mr2006067f8f.38.1758622538103; Tue, 23 Sep 2025
 03:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <CABjvBV7wgfSv-OjGf_L2t9ranXfzTQTSBdRAFODpHH-nFcLFig@mail.gmail.com>
 <20250910115733.21149-1-hector.cao@canonical.com>
 <b2fb1e8c-4b30-4bde-9b16-b9a0cd314b70@redhat.com>
 <CABjvBV6YZvufYXcUeBjY3Av=_VALWy2Dw9o6jGeL2FQTf1CgOA@mail.gmail.com>
In-Reply-To: <CABjvBV6YZvufYXcUeBjY3Av=_VALWy2Dw9o6jGeL2FQTf1CgOA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 23 Sep 2025 12:15:25 +0200
X-Gm-Features: AS18NWC5MGTH1hk8_GsBz89eVgDWvFrFZcV-fJagzqmwJd5y9WKKDV5QhHjGHXc
Message-ID: <CABgObfaSrMHT4JjBSdoRvXWcMwQ7EcJJ9e===b45U=10ybncXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Fix cross migration issue with missing features:
 pdcm, arch-capabilities
To: Hector Cao <hector.cao@canonical.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 23, 2025 at 12:08=E2=80=AFPM Hector Cao <hector.cao@canonical.c=
om> wrote:
>
> Thanks Paolo,
>
> Is it still time for me to submit the v2 of this patch ? I would like do =
add 2 changes:
> - add fixes:xxx line suggested by Daniel
> - fix link error for qemu-user build (since it has no access to migration=
 code)

I have since noticed the link error indeed, and I'll post a v2 myself
with the fix.

Next time, if you notice a problem with the patch you should post the
fixed version without waiting for input.

Paolo


