Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0240CF6AB4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 09:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdmTL-00011H-TU; Thu, 08 Jan 2026 04:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vdmTK-00010Z-Ro
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:38:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vdmTI-00074T-VZ
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767865104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aLOrgB3Sc8AsjTZNhs5mJNaMbNMsQy/+rfVGmvcm3ZE=;
 b=LN9LOeh9XAzafcLqFl4gvVsY2zZKdKpJZC+/nXxcD80JoPJH2YMJtxffYBeAxzyY76c5tw
 UHfuotx5k8Tq9RAPBZxPgIpFmG+rzKdkWFJHEtZl0DfyelpToBQ1bPIF8/VZEkOEV3iLsl
 aL/hSQmahnPAnnwVpsdBwnAagQHxfs0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-iXWlXi_LOWuy3TW9dc6meA-1; Thu, 08 Jan 2026 04:38:23 -0500
X-MC-Unique: iXWlXi_LOWuy3TW9dc6meA-1
X-Mimecast-MFC-AGG-ID: iXWlXi_LOWuy3TW9dc6meA_1767865102
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47d62cc05daso18227115e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 01:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767865102; x=1768469902; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aLOrgB3Sc8AsjTZNhs5mJNaMbNMsQy/+rfVGmvcm3ZE=;
 b=iTxUtBVwoapQIcTPcY61lHhAzElb8H4xJz0JlMxTd+oQk5cT8RkB8IGMqqgeDb4fbP
 +DKw80iAAaTd00Mcu65nDAXWF+0Xem/ZAL4OVfZwDrX4hqUgHdT1aRz2A/HHy6BKUUn4
 hBUL0JqAuyIdY5ZOC5RI76DHM6a761vgdBL+mfCz4qr8kkIrncHdlZuwwyokutekc0ne
 wGDNf9Q8Z7vCBcxiorNzoIuXw5lX7r2XbgdSG0NGr+hzA7CRpcVda8G1pirrO0eQIWXz
 lmZtu2ix+WBnrWKl9pg2N1EkM3PKYm4lANynXIEz/dGA/OZi4KNWnhi7hEIUILQTr5wl
 X/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767865102; x=1768469902;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aLOrgB3Sc8AsjTZNhs5mJNaMbNMsQy/+rfVGmvcm3ZE=;
 b=pr/MqyGHj6pBH0aCNuAsCDqfyHgZD8Am8WS/2EAX6SGLjDtPdMET/bKcoOWfmbRWdL
 iGijLYtE6GQU3H0Jm+iMBMrq/o/iOZJhJTXLKkLz+qUSEJplCLEoiHAquzHPZ996KQ55
 +Cai8+b/kJiQHtHhBG600rkNwrh+uZ3dolxH0e+YB5hGIwYk+v8M0pjI73yyXBvamGRp
 h2bXv4XxitZd53kc2POaJDNy/vO0G1f5ScE5XlYAymvFo/bRiPyUbftgKGdlLomsUreF
 psOFWhWjFC46a/aNGR6zT9pHWLUjTjRBLKGsXCrT1FkVN2Jn/pB9Jwljsr+mMPsI1BgB
 9v/A==
X-Gm-Message-State: AOJu0YxDFrsoYlk5G2d5aXjbTnw+U7u0iDjN4SEgjo/M8h2zcsP/xgDL
 OxYx6g7kimsc5PSgnvGsvOITu1ZI8fqJya9l7KXghgFZIctxDfDGRZ5dZdXz9Vw1w70SC+HPfSD
 CpRfiARqf+jdvXzNG4xnIaAkodIxYBNVddFKsPHVOXJm70clfgeGASq0bud+p8ztnohQac5LSH0
 Gp8diYmH1vAcr6RE44DteymCWXTdl8bHk=
X-Gm-Gg: AY/fxX43mBS2MzAzUY72Ucnx4KJBBUvyFsqLgA+NnUlHKgCeZX73DsYvOVmbH6ZUCdr
 ydB64tFbzy6yez0B0kc9gH8j96kleuusOEFe10pRdmhU01RGrk8+Brhbjvb7rZfEgMyh5x+4wqj
 QVNgTbpCwgItss4x++4wn5TZa3FBITujVN1xMiTrSTziKzC2VGFthlaRw8lzFCIsdVO5A=
X-Received: by 2002:a05:600c:1988:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-47d84b52c14mr72707625e9.35.1767865101662; 
 Thu, 08 Jan 2026 01:38:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE623RRl0FJqy+fDxToZqQqH7leIw524BvPCO4VnZC9galE/UhQNhdbFGiDKYqaCSKS9e4ZcNenLufoCif2+Bw=
X-Received: by 2002:a05:600c:1988:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-47d84b52c14mr72707395e9.35.1767865101315; Thu, 08 Jan 2026
 01:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20260106203320.2110372-1-peterx@redhat.com>
 <20260106203320.2110372-2-peterx@redhat.com>
 <CAE8KmOwA-SVy1tQOzAKpa6B4uoVw=veMcn3qzkF0KJ8Cq0C_8w@mail.gmail.com>
 <aV6T-JDXv3wa7tdc@x1.local>
In-Reply-To: <aV6T-JDXv3wa7tdc@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 8 Jan 2026 15:08:04 +0530
X-Gm-Features: AQt7F2r2vHKVhVFhD1-xU7U6EVrWM-CEkSEyPKyUrQJeq-JlIEZHtIP8CgdLLjc
Message-ID: <CAE8KmOzCYg_55J9J6Dh6Pr2D5wp_YLOXZqa4cm=Vt35ZDkiUXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] tests/migration-test: Remove postcopy_data from
 MigrateCommon
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, 7 Jan 2026 at 22:42, Peter Xu <peterx@redhat.com> wrote:
>> * Should 'hook_data' pointer be g_autofree too? Where is it free'd otherwise?
>
> hook_data is freed in end_hook().  This patch doesn't change that fact for
> postcopy.  It's the smae to non-postcopy tests.
>
>> * The changes look okay; But if tests define hook_data = NULL; Where
>> does it get populated?
>
> It's populated in start_hook() conditionally.  When populated, it is always
> (and a must) to be released in end_hook().

===
$ grep -Eri 'test_postcopy_common|test_postcopy_recovery_common'
tests/qtest/migration/ -l
tests/qtest/migration/framework.h
tests/qtest/migration/framework.c
tests/qtest/migration/tls-tests.c
tests/qtest/migration/postcopy-tests.c
===

* Only tls-tests above seem to define and use these hooks properly
along with the hook_data. Postcopy-tests and all other users of
start_hook/end_hook don't seem to use [postcopy|hook]_data at all. Do
we really need this hook_data parameter? Couldn't it be defined as a
tls-tests specific object. (just wondering)

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


