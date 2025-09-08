Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1400CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 15:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uve0s-0001a8-LA; Mon, 08 Sep 2025 11:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uve0r-0001Zn-BS
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 11:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uve0m-0006HH-JV
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 11:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757346147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=if19pmcHZ2lgYCxalY3B8NtguCsBYfluVuEXviZT2WA=;
 b=dAPA470Re0cLLsOwb4I7wgKgLTpGP9Q97q87B8oCDPftSzPaYzyFV0vt6OgTEvS7B88gmV
 cRbzI5r2vJkIUxBuC9Cwu3UFkzxyeSIPyxp13yuIk5g24u1TFnUNpHFRE2q9MN/Xjry1uW
 jhWmU5YhFbJBhaq14yZ+R+CQvDr6e10=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-6u6OqP2BMQulxwSAlWL2Pw-1; Mon, 08 Sep 2025 11:42:26 -0400
X-MC-Unique: 6u6OqP2BMQulxwSAlWL2Pw-1
X-Mimecast-MFC-AGG-ID: 6u6OqP2BMQulxwSAlWL2Pw_1757346146
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-806f812a0aaso1172795885a.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 08:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757346146; x=1757950946;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=if19pmcHZ2lgYCxalY3B8NtguCsBYfluVuEXviZT2WA=;
 b=Ohi2zTt2EQcQz3/+Bq4YB7oLHpTo0VZ7C4Td6/rGi9+92+zEpHxu3BjdQoP2N9ZCYy
 7Ac41bgMgo2Wddb2N9pRRMVzc3Zc9rELmNU65ROG8KnqrJGe58jwJW20YfE6H5SMkONm
 aGyf3eiUIrOa7MqE9DDAg1n62IBM6O5WdJijF6TTYQ7k/SHBB7XCJereaXjzWVqLRS3r
 MznOIe4K9TxMXJU+OTBcLav1yIV0R5Jn/2l3pp+iJy6HH5dlaPCwfc+bMXX2/noS1g/B
 2mMlDUeCBW7PeCT6ZgbEcYREM091H6enKs9mDaNQVJm9qS3LFGJZXcpcfuxV1bLBMLYA
 c4Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjPmCMZ62QNeARN0JFWlbUMp4aTEDBGROsssC8wvEhE5Wo9QLwcK8dslMQJh9vSbMtQJJbr88wUGF6@nongnu.org
X-Gm-Message-State: AOJu0Yz7VOi5Ag7GSWFdeXU40Z2ewxWvlGyWWNNJgDA+CK5+3YhuRf41
 vAMc2pXUzOov7qqbfWxjnv5sAa+HyvkARrjh3MRz/51eILDbTdo5Y59Anzz+1M7ofxb/vNNeKEC
 EKJc0uMm2CprnpITx3Kv8bLjgVdADpjpav3F13BXGXsWLZZAXFWoDsD2x
X-Gm-Gg: ASbGnctbh43WGy1Frm9SbgTUvLYnEmPZIOUCGorzfWncCD4vlq0glBfr/bGsWbSGuEI
 RJaB/QWuKA4d8lAdz5jHahRRZ5M+RHFDZEt1MuBkKEbO/wKYUhceXbGxUFbb/wvVuH5B4eb9VUu
 N5lDatHLa9jG4j4BZXn8ScuY07UDWnJUrNwbdT5/iFrbYlZxpKPBfdJrXzh0LSzHqkCcwB26PI9
 4zjrfM3BkRkQIpMjg17tv8YhvUuD6rmltkc7+sUhnCQp6ldk7Xz7arve6V60SRwNbiqgpgczbg2
 gyp4DEzEMcEm0lmYsf/a+CRilc8Q2kdfPPT8pyewopFsKAWwVDPgiCm1+ZS754SyQ/bM5xKa9Om
 fDpQX8d0De/JllGte7FQBdg==
X-Received: by 2002:a05:620a:25c9:b0:816:b56d:2103 with SMTP id
 af79cd13be357-816b56d2a38mr474421985a.53.1757346145478; 
 Mon, 08 Sep 2025 08:42:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwfzvHcSNZBXqHnsRvIckAtGYWnfmjTeuHo+YSv9WpDMFQuyptW0betzYcQM8XeZuU0acNZA==
X-Received: by 2002:a05:620a:25c9:b0:816:b56d:2103 with SMTP id
 af79cd13be357-816b56d2a38mr474416785a.53.1757346144806; 
 Mon, 08 Sep 2025 08:42:24 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-816be049587sm353587285a.70.2025.09.08.08.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 08:42:24 -0700 (PDT)
Date: Mon, 8 Sep 2025 11:42:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, mst@redhat.com,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, berrange@redhat.com
Subject: Re: [PATCH v3 5/9] net/tap: implement interfaces for local migration
Message-ID: <aL75XyzSI6lEOKF3@x1.local>
References: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
 <20250905135039.2202924-6-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905135039.2202924-6-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 05, 2025 at 04:50:35PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> +static const VMStateDescription vmstate_tap = {
> +    .name = "virtio-net-device",
> +    .post_load = tap_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_FD(fd, TAPState),
> +        VMSTATE_BOOL(using_vnet_hdr, TAPState),
> +        VMSTATE_BOOL(has_ufo, TAPState),
> +        VMSTATE_BOOL(has_uso, TAPState),
> +        VMSTATE_BOOL(enabled, TAPState),
> +        VMSTATE_UINT32(host_vnet_hdr_len, TAPState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +int tap_save(NetClientState *nc, QEMUFile *f)
> +{
> +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
> +
> +    return vmstate_save_state(f, &vmstate_tap, s, 0);
> +}
> +
> +int tap_load(NetClientState *nc, QEMUFile *f)
> +{
> +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
> +
> +    return vmstate_load_state(f, &vmstate_tap, s, 0);
> +}

Instead of hard-coding vmstate_save_state() / vmstate_load_state(), could
we make tap's VMSD to be a subsection of virtio-net's?

Multifd already doesn't support qemufile, but only iochannels (which is the
internal impl of qemufiles).  We might at some point start to concurrently
load devices with multifd, then anything with qemufile will be a no-go and
need to be serialized as legacy code in the main channel, or rewritten.

IMHO it'll be great if we can avoid adding new codes operating on
qemufiles, and also avoid adding any new custom VMSD fields' put()/get() if
ever possible.

Thanks,

-- 
Peter Xu


