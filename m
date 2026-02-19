Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604E2E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 09:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt0Lf-0004gW-O3; Thu, 19 Feb 2026 04:29:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vt0Lc-0004fw-N2
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 04:29:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vt0La-00017a-J5
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 04:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771493360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0rtI/blLUs66pfO4kMCG6WxO3rHZJx9W/TDUMhLZJY=;
 b=QXeSURC2l84TwJILsfh8GWQ2OLDpljo8FxuVXjSnWu7SIoLyjLsqratBH8TdWIE3QKY1Zh
 pEtD0uCADUr04pUSGBVQdc1SAq1z46Gl19mOJ6+6ooa/+mt1av82Y6Up/AZiY6lfCd6WAn
 pJEn99qOWGiDIKQZ+prS55eAaie+LaE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-NMXn7YCDOYeA8il93wzFXg-1; Thu, 19 Feb 2026 04:29:19 -0500
X-MC-Unique: NMXn7YCDOYeA8il93wzFXg-1
X-Mimecast-MFC-AGG-ID: NMXn7YCDOYeA8il93wzFXg_1771493358
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2aad5fec175so28362705ad.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 01:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771493358; x=1772098158; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R0rtI/blLUs66pfO4kMCG6WxO3rHZJx9W/TDUMhLZJY=;
 b=Cc4foxWG0FQbdCt9eBta8GoyDjMP0vCjRUto0KvtkYhB/5q+JmLzbiy4hAOmc274zP
 QNHZuDTFl9WhuPA02ze/VISoYTh61G+4BKh+uhJ12zKTY5DKQk9gSkyk0KfX71kIvWog
 leEBXTocrIzpW746HP0sRT0Q1ieQCU2CaTBFkd7beFNaNG+BNSV78T6NGIWYpFTs08o1
 UfC88EvzMmeio/Hoxo9ou9EeiM9A4GPSx6eOiUEbDqncYvNFX1BC1gi2SHDzoT8lCTrl
 nSzmBt4SZpqvrnS1a2Jm45hvzEStkMW4pW0+sBnRGERJQ3VwG+M8ABDVHgW2WgfXHpB8
 isIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771493358; x=1772098158;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R0rtI/blLUs66pfO4kMCG6WxO3rHZJx9W/TDUMhLZJY=;
 b=lWJfM+KSJKR+CTP7czOs43g2uCvP5Peny/Hy8YDn8n5eqM3bJwQL86ZUqE4zwQShGO
 4M6WyzHJwqcBUSPjUPUhJbz+YNQ9kweVu1+VpFo0gFbpM2DV32tyqn+bm/zwND8DXHKJ
 59wCSUW/b45B7oVX5EJA6i8R3uQBBuOCn8/gFrGomkhWT+Krv7kWE4KZepI0Ff35uolI
 2E9TPYskMKZwCeic/M1Q2RYcENJdoTik4qyRXTY5pEqbB+Hhefx1MebYHf4oVHVp7meY
 qcz3b0DNhv4KrQmi+En+Y6H4JySHnfvvsxQALJGuCymTzZUquqjh4/dD0MGcJTCJikf1
 52Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCinTLT3w20mBdVoeweXoGktuonXH6p0MCP8sHJpIfDGMTCVsfilKxvan0LNQIxvtrx8U3RLUXjd1A@nongnu.org
X-Gm-Message-State: AOJu0YxIojRBE5pB1CVcuSgBWPMxVhhXd1MxlnbYBZPuTR0faEXkBM5E
 iMcGSXuHRg9o4oRC6iwSX0zen8QF0UTbIXxX6oYFwJVibZfAwnBXvQVM1wKdAVYFYd3L/LSdNUs
 0JzxmLuX243sBe4rHfaOtJiYL5vozesh4OsG/z/v3bSkuR9wda3y3s2op
X-Gm-Gg: AZuq6aKc/OKHF8LUAMRj5C1cl5lxT4OGwv7MTeSTCi5DyyJ5aw+s1blItlH6I7i+v7Q
 J8Q1txoLMSRGapBGUAILW9x4NK18uKA3tLr08wpY4K4ydJLBBJvI9ubD/L9GN4JPO0e7xYGPSgJ
 fRMpUKRu5Zws39kwlMhdW7p6FrFB7PTC5diSuQ6vE3EL95V3A/wsIM6alX1E3iG2IE23BpY8GQQ
 WJ5SYIFDNJp0LshZ4fAtUihQOm5jTvayU0kBoxylcPv1XnaiASXEgWITKVhPTZMrc0s1IVGu6RR
 MYDehXXCOaCJbImkIkgs0gkEcNppoLO+w5SCAAZokscWI+i04SeOg6ttlitVCYmI1oBQqMapriN
 dc25TNjWBLuTM96rMT+/A+IyG4i+QQDtP0j6htNECoN2RmwhQP3CjBECyzEoxAyMlLrg=
X-Received: by 2002:a17:902:d48c:b0:2aa:e6c8:2c73 with SMTP id
 d9443c01a7336-2ad50f33f69mr50788975ad.37.1771493358242; 
 Thu, 19 Feb 2026 01:29:18 -0800 (PST)
X-Received: by 2002:a17:902:d48c:b0:2aa:e6c8:2c73 with SMTP id
 d9443c01a7336-2ad50f33f69mr50788715ad.37.1771493357903; 
 Thu, 19 Feb 2026 01:29:17 -0800 (PST)
Received: from smtpclient.apple ([117.99.83.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a712ed9sm244490475ad.20.2026.02.19.01.29.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Feb 2026 01:29:17 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v5 33/34] qom: add 'confidential-guest-reset' property for
 x86 confidential vms
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <87pl613wxi.fsf@pond.sub.org>
Date: Thu, 19 Feb 2026 14:59:02 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DD830601-D059-4702-9D08-8A461A02A287@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
 <20260218114233.266178-34-anisinha@redhat.com> <87wm093yer.fsf@pond.sub.org>
 <ECE353A6-A0BC-4A3A-8D80-581CE9150C5D@redhat.com>
 <87pl613wxi.fsf@pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 19 Feb 2026, at 2:57=E2=80=AFPM, Markus Armbruster =
<armbru@redhat.com> wrote:
>=20
> Ani Sinha <anisinha@redhat.com> writes:
>=20
>>> On 19 Feb 2026, at 2:25=E2=80=AFPM, Markus Armbruster =
<armbru@redhat.com> wrote:
>>>=20
>>> Ani Sinha <anisinha@redhat.com> writes:
>>>=20
>>>> Through the new 'confidential-guest-reset' property, control plane =
should be
>>>> able to detect if the hypervisor supports x86 confidential guest =
resets. Older
>>>> hypervisors that do not support resets will not have this property =
populated.
>>>=20
>>> Double-checking...  This is an static ability of QEMU, and QEMU =
alone.
>>> It does not depend on QEMU's run-time environment (host kernel, ...) =
or
>>> the guest.  Correct?
>>=20
>> The run time environment is the same as what is needed to spawn =
confidential guests. That is, the host should support confidential =
technology. The host kernel/distribution should support confidential =
technologies. Plus the guest should support confidential technologies. =
There is nothing additionally needed to support resets. There are no =
additional dependencies with host kernel/environment and/or the guest =
etc to support reset.
>=20
> So...  if a QEMU with this feature succeeded at starting a =
confidential
> guest, then x86 confidential guest reset is definitely supported for
> that guest.  Correct?

Yes :-)=20


