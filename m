Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C1EF43832
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 14:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD1h2-0006LJ-9i; Wed, 15 Apr 2026 10:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wD1h0-0006JZ-IL
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 10:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wD1gz-00086a-4I
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 10:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776265092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B4VS5yt8upz/23YAzmep+J+R8sobnc1RAYXC71CZn/A=;
 b=eHmuz6WT50OAv0l5xIHS8T3ahXr+Kl3a68olmbbJyTF0pHJMVC6zyvz29X+1ByqdBIRy1k
 0WlxYOFEoXN3dp6rnhRq2Tf/q2V0nvAqFh6DfsjUptSm8psL2uR/0WvpvBLz0stAExZ03g
 SdQUxAQ2x3/S88bHB/zi8HcjlajZ7LI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-1J_waQXoPzqCS76GzpzJbg-1; Wed, 15 Apr 2026 10:58:09 -0400
X-MC-Unique: 1J_waQXoPzqCS76GzpzJbg-1
X-Mimecast-MFC-AGG-ID: 1J_waQXoPzqCS76GzpzJbg_1776265089
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8a8ea3f1becso187672076d6.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 07:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776265089; x=1776869889; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B4VS5yt8upz/23YAzmep+J+R8sobnc1RAYXC71CZn/A=;
 b=I57OD2Ec5DT3+PW0wJdiQef0sQKNkeg4yvXYb0/euvDjpp9DaHJDtsF1fjgvY3cqKj
 zBbsUGbB0hfhfH5lo7JG8yD+v3obPNMcMEnq5Zjf74708gwp1Qb48sn6jhZ2ypesIIlp
 FqFkY+kTsHvXphgoAVyMAcFoXoyrSy9PkZB8yhUQJGllVa/WnU6XmTQU22cASrH2nczO
 o46Y3eRp3xOU51zkIAecI7TCS1BGFC86lc5/McUJSpu3j3NP83gxnpN/2Q2t95nyWplu
 Ar6y6IHjRo5smOY3BpfkN082HmdanB+bdDl6qagjCcnksLFZXTytWW7DrZPZruciXVZN
 cD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776265089; x=1776869889;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B4VS5yt8upz/23YAzmep+J+R8sobnc1RAYXC71CZn/A=;
 b=qYdGQA+GHYTOyx/+ABpmA0J+SRGS3Nzqzx2RoGr3Yow77ZJus5hdaTgIW6hdRJ6rQB
 tmd3vBWpTIUOAohIhaZ1aGDvvOc6UCY/utooprzeyHjvggu0qNgjwDPWD5elKa9iSioq
 wNldxiHkxOfc5FMxLMh2E6dhJCWsTCI0fuzIRC89GD05hzbvUwpApbeOGTB7WVZOf99e
 u64WrPUHq60mROuDgzxncfuGvw/TNCzK+eSAKfmjFqeBt8sRnkKrJ8Yq/DPM2Pe+bKF7
 fkjgRfOITm8YNA+umOzv8IJ3GUUebCGWlrby6fjLnQwZ2HfFbi1aByh5/9XfGndL6IHc
 LLGw==
X-Gm-Message-State: AOJu0Yz6xV/oRLHAMlPdRx+WKa5ak+0In7E8k+E4KRWccHQOXaKHbKrD
 MIEsHAdfC7s7JtCavLnDOKfTwItFkMUFSrJMIHBzHkBZaFSxSgATn+5Geb0kzChq4b0IwvlCyMe
 lYmGqLFJo1Usv3JoGw6XoMpLrAQZ/9NM+OVks1N21Z5leVRO3Ukk5ZE0d
X-Gm-Gg: AeBDieuOuZH9r3PXKW9lCjFUUfaoz7jNVnZybsSjUFAKD4Px/rOCAUpQ/pUyr5MlpD3
 z/9lFPGUZH9sNzJlNpK2/zqqGB5xIMUZBRC4gxNCzTvCm09q3SNr/MUUf+p2wJcoadtamj8wQNE
 ZdhF2EeV+EK5+72Mfj9nG8Zg8o5ahSAwo0sMZM6lQw4q9CYtjtMEgd0lYEWrW552aw6FdaHxsRu
 6IRZQJyH0lD9XDjRxMZSNgyYeeJmTWJiMLupYgL2x7OrH3dPP6U/bm8iC2/hYz3cPA24el4Z1MK
 +QRfOZxSFYBhBTNLec5rDU5iKo6Jz/lp9fDm2S9OL/X/ubn59TH0x1L46foC5HupdffaAr5/lyc
 GsOBlVqeuw9ZfA7e8OYXR0VEFdQkhznLVp2NyHSqk6P7UiI9TPbLc7Yp2IQ==
X-Received: by 2002:ad4:4ee4:0:b0:8ac:abc5:8756 with SMTP id
 6a1803df08f44-8acabc58ad5mr198988106d6.25.1776265088341; 
 Wed, 15 Apr 2026 07:58:08 -0700 (PDT)
X-Received: by 2002:ad4:4ee4:0:b0:8ac:abc5:8756 with SMTP id
 6a1803df08f44-8acabc58ad5mr198987466d6.25.1776265087695; 
 Wed, 15 Apr 2026 07:58:07 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c938368sm16845966d6.5.2026.04.15.07.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:58:07 -0700 (PDT)
Date: Wed, 15 Apr 2026 10:58:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-riscv@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-s390x@nongnu.org, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 14/27] monitor/meson: Use SPICE with migration HMP
 commands
Message-ID: <ad-nfXeL0OlIb6io@x1.local>
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-15-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410195323.17937-15-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 10, 2026 at 09:53:08PM +0200, Philippe Mathieu-Daudé wrote:
> When moving code around in commit 27be86351ec ("migration: Move
> the QMP command from monitor/ to migration/") we forgot to update
> the meson rule about SPICE pkg-config flags.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


