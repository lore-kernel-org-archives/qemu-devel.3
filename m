Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AF2CCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 16:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Qnt-0002iC-PD; Thu, 16 Oct 2025 12:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9Qnr-0002hr-Uv
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9Qnj-0004ta-UQ
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760631959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oaLW06Ajkd07Au4v3PLf8Z3HIbhqhcVbtvcxvqYcnSI=;
 b=H9rdy4N8aJBciHL9udgMHSzZGngJCUSAcHaRl2vmMRPw7ySI265JenBmVWajwV/0tv51ng
 /Qq7iZzkbxdxzXA/ie29E05ij7kVCIcMBI3FxqlA43VU+OBzRSyId3EQu9vg4T+FLbNEqp
 yG99VF7s5QnM4EfKDi12BTfwLEzd1RA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-fw7aqWb6P_6ay6_OCXPmqA-1; Thu, 16 Oct 2025 12:25:58 -0400
X-MC-Unique: fw7aqWb6P_6ay6_OCXPmqA-1
X-Mimecast-MFC-AGG-ID: fw7aqWb6P_6ay6_OCXPmqA_1760631958
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8635d47553dso275712585a.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 09:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760631958; x=1761236758;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oaLW06Ajkd07Au4v3PLf8Z3HIbhqhcVbtvcxvqYcnSI=;
 b=LzMJN1bEIL1vqrgWFh6a+VzTOtR6qgKYgZ5QVcyO+4r1EOS7SOUq9skD/L45OBiI0z
 30+c8aCmjL+QfnIYeaA0dXQdMiBIK2Qw1gpN3lX89vUThSRQYzKW+BiPVfg43EGAxmXl
 oufIBb0iD3Z5mQ0NAbvoKxTx6TpXnP8UjUyk7dLsU1vXBiM0MnfbGGn8AYne+WhLP7bt
 8q4wBc3Ve/612d0hYLyXcDOjXw16vTSgbRVpgycWIzgvT83qwlZHO9OWingxIoSwnrmi
 yrE6bYTB1BKJIGOKSI+xHJS0mSxXch0tXBOPfyGcF8wBj0hpWIeisA6l/zb/pnWqIRJk
 re0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFkPb6SUcnpjXGTT9M2RVVc/RyyJmJO1KwZNAgTCX+J26cSxq2RxeksOLVyfpAoJ+JP5SCqwKAC9A9@nongnu.org
X-Gm-Message-State: AOJu0Yw2gba4gXKCBkpmcaydVeDZ/vN+WQy+743fG6d4DIpIs+6h6F0d
 p7urEiF+1ucZ5f1CJTZZMfMxLbooA5YJ0bqZdyrFXx/TRI4INw8aJVH06SwUMuIaxtKDbUM1i6U
 QfiPOvXdKN0xk+S6v/M1aatti96048pV/2TQ4TgVWxUxd5nDHnpp1jwcq
X-Gm-Gg: ASbGncuYj6bulFq11hdZMDxKY2HsJxqzHvpALwHohubpFdrX8ppCxyNIrvoh3lNP1k2
 nVY/Iw4HDUvyLzX3mmArMIR6xe8UgadAc5XEf8ZZSCFHViBNuS3ewI38r1ZNOfOj0lGaY3laVlE
 NDeqQHEgLtZxTIZjQYPQuXJT93V42dpKc3L0zUKkZ6wJAPZ2RFC3FsHvkU4+l2vpJGqY6HVOkc6
 maoWBLYsW54FpDX4L77Kd3zMu0CelkG86isHkOVnaQE3Clg+tTlYGcHlsGMl9lWZEmAiaKchZom
 kxUQVtgiIHiDwxQdxQ7HPLWeoUs/SwNGowNY1ZwYoPL0/PG56UkN4HGEIySBYczt+bw=
X-Received: by 2002:a05:620a:46a8:b0:849:a60:79a5 with SMTP id
 af79cd13be357-8906e2ce12cmr66137685a.18.1760631957418; 
 Thu, 16 Oct 2025 09:25:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE37LrzU+zg7574tMeES8ly16GbvO2+jZTK+B5MQo3RdrrdldIsU6QDvn1A8h0xn5LcQJTlnw==
X-Received: by 2002:a05:620a:46a8:b0:849:a60:79a5 with SMTP id
 af79cd13be357-8906e2ce12cmr66133285a.18.1760631956933; 
 Thu, 16 Oct 2025 09:25:56 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-88f38bf42dasm221576285a.63.2025.10.16.09.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 09:25:56 -0700 (PDT)
Date: Thu, 16 Oct 2025 12:25:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, jasowang@redhat.com, farosas@suse.de, sw@weilnetz.de,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 philmd@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org,
 michael.roth@amd.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v7 16/19] qapi: add interface for backend-transfer
 virtio-net/tap migration
Message-ID: <aPEckcsXUEjfDk2z@x1.local>
References: <20251010173957.166759-1-vsementsov@yandex-team.ru>
 <20251010173957.166759-17-vsementsov@yandex-team.ru>
 <aO57SKp86zX2R8mV@x1.local>
 <6da192b9-7609-4cc8-82a9-1a445ecb10c9@yandex-team.ru>
 <aO6xqt5_1PDBwOwu@x1.local>
 <9a9ced95-583e-4c1e-84f0-af12a5800193@yandex-team.ru>
 <aO_nfsgM2CWEjyeQ@x1.local>
 <981b9636-0a7a-4334-b222-7621971e6b2c@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <981b9636-0a7a-4334-b222-7621971e6b2c@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Oct 15, 2025 at 11:17:27PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Off topic:
> 
> Didn't you think about moving to some context-free protocol for migration
> stream? Current protocol is hardly bound to migration states definitions
> in the code. This, for example, makes writing an external tool to analyze the
> stream almost impossible. As well, any misconfiguration leads to strange
> error, when we treat data wrongly on the target.
> 
> I imagine.. json? Or something like this.. So that we can always understand
> the structure of incoming object, even if we don't know, what exactly we
> are going to get. This also simplifies expanding the state in new verions:
> we just add a new field into migratable object, and can handle absent field
> in incoming stream.

Have you looked at the current encoded JSON dump within the migration
stream?  See should_send_vmdesc().

That looks like what you're describing, but definitely different in that it
should only be used for debugging purposes e.g. when a stream is dumped
into a file.  The JSON should only only appear also on precopy as of now.

We might try to move it _before_ the real binary stream, or making the
stream itself to be JSON, but there'll be tricky things we need to think
about.

At least it should be problematic when we want to dump it before the binary
stream, because there can be VMSD fields or subsections that has a test()
function that will only conditionally appear depending on any possible
conditions (e.g. device register states).  If we try to dump it before
hand, it may mean after device registers changed and when we stop VM and
dump the real binary stream the test() fn may return something different,
starting to mismatch with the JSON description.

Dump the whole thing completely with JSON format is indeed another approach
that I am not aware of anyone hought further.  I believe some of us
(including myself) pictured how it could look like, but I am not aware
anyone went deeper than that.  Maybe it's because the current methods work
not as good but okay so that no one yet decided to think it all through.
In short, for simple machine types, they use VMSD versioning hence backward
migration is not supported.  For enterprise use, machine type properties
are used and there aren't a huge lot so maybe not as bothering.

Thanks,

-- 
Peter Xu


