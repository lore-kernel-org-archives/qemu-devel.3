Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78577D0EE0F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 19:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNyma-0005Yh-H0; Tue, 25 Nov 2025 14:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNylw-0005QP-25
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 14:32:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNylt-0004It-Na
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 14:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764099135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3YRjauSNS84WaoUzSa+mR926p2VNUFICW7HqSaJcKXM=;
 b=LLy3Z/dap7Ll9SCkFF8ZhF5cjS1nhUAJ+6Iq7n6mOA8yUsCZ+I2cuILQH/ZLHtmvewCUO9
 7nnsqVpEZWoS0d4szltBsstWTiNhEcMCY9WEPrwnT3GxAnyBXjzK90KfNnjTp5blgZgcWv
 cg8prQqV76XKYhyGgh6znN7zpM4sRAw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-SY8aBZEnN2SABJgJCfchmA-1; Tue, 25 Nov 2025 14:32:13 -0500
X-MC-Unique: SY8aBZEnN2SABJgJCfchmA-1
X-Mimecast-MFC-AGG-ID: SY8aBZEnN2SABJgJCfchmA_1764099133
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8823c1345c0so65941896d6.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 11:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764099133; x=1764703933; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3YRjauSNS84WaoUzSa+mR926p2VNUFICW7HqSaJcKXM=;
 b=JesU8ZlfRCFTflyOgFoCErRda/Sg77Vkp1lv7OoTyks6XVIcVPqm2M4WAV4GWtV7Jm
 QOy04L4WmkeGsLuxHCBY/tL+rV2V4fJ3LG3ntv8WmlKjFMJGn6/uXstjD2BUX81iTc3t
 +FI21CCRwKYrDwU8iv+mQm0Fa9yiriznIbwFXXJHNkS1dTaOqIxzCWs5oedgneeGT8LJ
 kbxj69uBLA71aMsAShQn1Tt2W0FbS9qGm3lOeADMdr86m3XL8rsRSPJImMsSrptv/+u4
 a7iAvZBT5f+sOFmFEy151DJDMGeP3mkWu95+dqj0LBRgWSRsCKBzB6vbXDC/2+f+cKL1
 JDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764099133; x=1764703933;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3YRjauSNS84WaoUzSa+mR926p2VNUFICW7HqSaJcKXM=;
 b=LXAxeFUzdLstmLwUSSAVFBxf1w5KVgUmXFuRF+doWFTlBDMDATfl7PIuSK1iaD/HwA
 woinuUKNygqN5s8/KcI7e1DPsTng7Tj1aODzaLrysdtTa6ZJit1BM0CLlCpLhgvrHTvm
 Mi6mS+xBnjztFVa0Qo8luX9ABROFxShceRG0TeSygOtU8JuG92rpIa+cvK6MyYgltE96
 osdPozKBgQ4L/TqiAvHEoNqtJbjX5YM3KOEhdi5smaW+MeOApnTE/GwD5Wg3VvhF+YSV
 mZCkFoeBTav0f1EVWNdntHLHw14tv8MrqosE7uRdPIws8+zB/GJX0QJrlADk1WyO4IPe
 iHOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV04BNezWIz1+CM/ZEFwhGCxNBDpKHAWY6fC7kt1TKAMpuFJvEozjiLAhvXsvJO9BT2CIi6AKBaNABX@nongnu.org
X-Gm-Message-State: AOJu0Ywy+HcGvRNtBzP0MIkKZTwjld3Feh3P53dgkwP8iUZbD5Oeaftt
 ty6bU8gGtLO7zvQWbdEFKcNhVvaqie98GTk6Coi8JALkWgM47+tut5jlKxiHhA9WHdHC9O4c/Kf
 oQU2++QqDWCrwB35y3cLnei+9s+FsxtlHJ76eZolxsSqehudZS6NZrMht
X-Gm-Gg: ASbGncshFtOvLWFb7gjPkNE/p25pznk6GsSsUYifAS+FX3+pA01b9U52xcQgJDGWKZD
 vn0+2kiFj4caSxeJQwD8S98lOkiabsNb9VOLj24WJgoY1Snf0F6Ni2BJnQ0GhEPivdkjzHF4XZF
 qhC2YEm8tqwT9E3x2La+ESQUWtWiqagI64Hlv6FLUucWudIDudFWTWWqf+DZyCiBEzM0f9AcIjw
 b76bCSe0mD1RbNOoxh0ERMKtdQuslEOHVnZ2FH9u5Bwn0P1pmGmzssvGDaetjvpgInoGucABZAk
 Z2/QsONgXfVM0zS8kerbBnrll4MZvp65p2EGo7aXUWlycYVxoMdlDcQEdke4LBPgxY6hy4VbzhN
 r+gc=
X-Received: by 2002:a05:6214:20ab:b0:882:4dec:42b9 with SMTP id
 6a1803df08f44-8863aeba61cmr54749616d6.26.1764099133111; 
 Tue, 25 Nov 2025 11:32:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmh8Am8KAf/MqGzjNTFqHaKafrABHsC1gCM8BjSa4Ay8JBdKD7HCkiZrbNCA7S1xcsUI2xEg==
X-Received: by 2002:a05:6214:20ab:b0:882:4dec:42b9 with SMTP id
 6a1803df08f44-8863aeba61cmr54749246d6.26.1764099132608; 
 Tue, 25 Nov 2025 11:32:12 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8846e5ba2bfsm128441476d6.57.2025.11.25.11.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 11:32:12 -0800 (PST)
Date: Tue, 25 Nov 2025 14:32:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org, farosas@suse.de, peter.maydell@linaro.org
Subject: Re: [PATCH] migration: Fix double-free on error path
Message-ID: <aSYEO_S7FfAeZyHG@x1.local>
References: <20251125070554.2256181-1-armbru@redhat.com>
 <CAJ+F1CJ918Y9e=yTHFSqZo0QGmmD3aT6Zq+zxQ81t-gjKkUJPw@mail.gmail.com>
 <875xayxo6t.fsf@pond.sub.org> <aSXPhOV86fyaY53_@x1.local>
 <87ikeygd83.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ikeygd83.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 25, 2025 at 07:48:44PM +0100, Markus Armbruster wrote:
> My main argument remains this one: our deallocating functions don't work
> that way.  For better or worse.
> 
> I don't want the Error API free differently.

Yes, it's fair.

IMHO, it's a matter of taste, and maybe that's also why I liked
g_clear_pointer() but not everyone likes it.. said that, when we have
g_clear_pointer() it also makes the current form more flexible, because we
can apply g_clear_pointer() on top when we need a reset..

I'll follow your advise on error reporting for migration.

Thanks,

-- 
Peter Xu


