Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D946C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 21:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpBrl-00026D-Nq; Wed, 29 Jul 2026 17:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wpBre-00025w-HI
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 17:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wpBrc-0007wW-Uk
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 17:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785360655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=1y93ick3259HpEqyeTDsbQ6mQUYpK4d4bWiF4k8BDpI=;
 b=iXW5k9Rv0/c6tC1aqUjuBbCfnVzrGBbuykoCzD4MRK/otM6dtKDlvERD2xqgkSSUSU5rMG
 WhwuT0oCgaj8Fi3mOpFZhFcfHxhlF33iLWdAoqW1QDIho8e2LNemepmNoesaEDblJ6q+Eh
 RZCLBMWQxVW5Y8AFJ2ICrGgqVwv1b+o=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-1CLCKbnFN6q2_a1E-h2raw-1; Wed, 29 Jul 2026 17:30:53 -0400
X-MC-Unique: 1CLCKbnFN6q2_a1E-h2raw-1
X-Mimecast-MFC-AGG-ID: 1CLCKbnFN6q2_a1E-h2raw_1785360653
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-81eedabbefcso48128897b3.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 14:30:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785360653; cv=none;
 d=google.com; s=arc-20260327;
 b=NdsRL4uJpHUdOclCA3Fk6yUEYMZW7HPY4nMdBb+PQ4ZoBT+3uv6h6tv1sSJbLJBQfI
 zUgXAgz/sFKy2aUY5N3DfuFS808zdJ+wetkzplmTF6M+rwxkLQT+nX9SIXAqkNwduNrW
 mTIgXudHCNVc3Ki4223fLuSpqjT6Pg5ZL6m8VmvcclmyK+ugOb2OBa+vNQ0YblR3g5ot
 ArAjRWBdrtWRqhKfNAOltaQxMCLt++cOG4Ih6N2haWGWLMCHVaoJMWcpORRFX495CRVC
 wka1WOfRq3HBuqNAzJ7v6IPeKrYB3tZ8tunQKcecGxVVczDRzV+Oc3BNFxVqEpV7CQwU
 flIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=1y93ick3259HpEqyeTDsbQ6mQUYpK4d4bWiF4k8BDpI=;
 fh=OxaQKzCgn6hyn0RCh2n2TYHljlQPbG7ri9jbfVYTE3I=;
 b=b3ibOXTcVUbyQHDMSF8SwrT43FzRqIhuugbc3gDCmlPG45QCxX/oZ4rnjg2fEO3NiV
 2CW+5TeeW1yRvo/DUd6WUtrt2S+ZSjmd/Pssdsf+DVBw4B8u+ameOYq2tqnRKoIYJa25
 lMXhM9RKHBEDiH9H/7HLQrmjaLFEANLz2FtU0CwgqSMBT7MshzSWl5sBBse0e15q15rl
 3iv0IYCjeVQjJBCfgoygEQoguAICqExuYsQBfH64aqEJ9aXc3XyHPq8u1LbXti24vobx
 gVWAh/DvfowsmJoQKCnRMeRp2AqKrIEuZLSnYl+HPAzoadsfgKVzMeeGZaxWJVTg8cuM
 b4bA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785360653; x=1785965453; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1y93ick3259HpEqyeTDsbQ6mQUYpK4d4bWiF4k8BDpI=;
 b=A53BEI9/s1uUdgHy6ry89dxoHN9nDGCRcxgGxaEKICqhz6a9Z8MxRmhh+zQ7cIWbwN
 kzlzODrkcnPlEOlknBzenwyIGYhpuKmSbLWGd/dlVubeEF5ppy68tSP4MzkZFqFbcnsg
 vkblxurXBoYFvSKPATNljoKy4gohib9K8aV3Ygeyj+7jRY/aAEFgWCmZ17Yn/zMP+XHI
 GJGeD1C9WRh0+vdzjrkbft6uWRZZ98zGAEOR6+F+753/ywoUMWFIXz59sFRKOoidOvPS
 jfbledfQGJApUXuwnxvc+DEkA/yy07v2auuW26YMDWDBiW91Yx45SYHMEPBF2RfRUjgm
 XVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785360653; x=1785965453;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1y93ick3259HpEqyeTDsbQ6mQUYpK4d4bWiF4k8BDpI=;
 b=Vn+oR8fFBNwQ1XAJXRbH4IFPu+/I5U+cTgkFblJWavdcbaNumVMvWGlqaZinu3KIKX
 /3yWmn4EMWoUs9Vofzswrc7Qa4vLleVUqqOvYQjnm/BD0qtq0l/7oSsusHWvxXcO6Ozz
 8V+ZchnJ3mROQ8f12j3fR1jfrXFFyfzrzJoVaaNTtXC4YHq7GyLc+6rKmMTIdfjqzqLR
 ozIIaNBJNqvhfquVs6EXtEgHq6O3i8EF1X3/K2K4VucDxuNueMolREloPdwjFHWlwqT6
 4NWcJDUKWTAq0V6RQTtezW4BEOrHwpYaQ3XXi8j8rjwt+1LzUlaZM3IoFTfOkWPvkJeM
 dGHw==
X-Gm-Message-State: AOJu0Yy14MSM99N+tnPL1yIa1i7rAsg8YOoZI162bZtha3F5+vu1hqaE
 1KWgjHw8IRYQhdvya8x1g9wQAV6INJMlhwUhQwkVXVj/mH+BA00GyQO0YN1N4mhGZEQvX8BLSws
 iKzEbJMHUk0ztoU990YU1o8RNGN70VsT9b988PtO2RzaKYFumALRyGCZoUP7f6a6n5DpDWnpt5u
 VMc2OI0D9y+HZix72aTFq2rGnLzEuiisKC3KHd4jqayA==
X-Gm-Gg: AR+sD12/2QQA0GMQrl5sefTkZKyYBzKVHpy6w/vxswEDP98YOgtaYnIv150jzi2c0YM
 3yYSb5stgEq9VDKF2xIYZDbmYM8NhbsVPstFj2L5i0S9591SBBr8AGl+KbOZjgxGsJp0RjcFZm6
 v/i8KRd+70MhwBKuNuqejJQb30FTV70FPFb9LXGuTz4iD3vGWN22nxeWuMd5I6DyqkXmcNxQdJn
 nugC+2ETdLF1m8I
X-Received: by 2002:a05:690c:6c05:b0:80c:85e5:8751 with SMTP id
 00721157ae682-81fb5df9468mr4051087b3.58.1785360652889; 
 Wed, 29 Jul 2026 14:30:52 -0700 (PDT)
X-Received: by 2002:a05:690c:6c05:b0:80c:85e5:8751 with SMTP id
 00721157ae682-81fb5df9468mr4050957b3.58.1785360652362; Wed, 29 Jul 2026
 14:30:52 -0700 (PDT)
MIME-Version: 1.0
From: John Snow <jsnow@redhat.com>
Date: Wed, 29 Jul 2026 17:30:41 -0400
X-Gm-Features: AUfX_mxvdEU0bnl0En9vHAvguFQJcNrIwmAtayQCxv0E1FnyW6pIn35LPysjomI
Message-ID: <CAFn=p-b9_5yGRtKaaE4S6AmeP3vt+1FjUp5fC5a3xH3wdJJ+_Q@mail.gmail.com>
Subject: What packages does OpenSUSE 16.x ship?
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Apparently Repology doesn't support OpenSUSE anymore, for ... uh,
reasons? [1] - Does anyone have recommendations for quickly figuring
out what versions of xyz library that they ship for the purposes of
determining adequate minimum versions of QEMU dependencies?

--js

[1] https://github.com/repology/repology-updater/pull/1576


