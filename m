Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C56AD43341
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 19:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTm63-0002Yg-Q3; Thu, 11 Dec 2025 14:13:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTm61-0002XN-O9
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 14:13:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTm60-0000n8-4H
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 14:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765480378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YCmgL76a6bhZQ7y78yvYotS+8U6wO+0AkufFmlwHEEA=;
 b=bHFisvBskkamkYytPQnCXo6neg3db1ZLDGkdm8ppf0NIRicRa+/TOK4YRVzrQW0S7/VXQm
 tnXkddh710+GrwD5q6xyN8gzmgH8pWfEqRiFFsM5MZ/WBhL53uxwJZXYbE/Lv1dAOEFfXM
 yAAQLPwQq4/5aNKWSr9O1mvGzkimX/8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-XYKI2cKdP6uy1-IOmhd_4g-1; Thu, 11 Dec 2025 14:12:57 -0500
X-MC-Unique: XYKI2cKdP6uy1-IOmhd_4g-1
X-Mimecast-MFC-AGG-ID: XYKI2cKdP6uy1-IOmhd_4g_1765480377
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b9ff555d2dso110991185a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 11:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765480377; x=1766085177; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YCmgL76a6bhZQ7y78yvYotS+8U6wO+0AkufFmlwHEEA=;
 b=X7kItMNT/r3KnNv/4BdaEJPHoSKEXpQF6tYMORERnlbOd+hSNKlMcSTx+/lQDc9YvV
 RHdPkKhQn0wsau7Fc8mH9renrBiKEOCePJ+UegIiu4nGfpzVXihhy0BBYy2ZDuVBe3Fm
 ZXyp+Ooa0b6sqA9KSvcYW+KfJbmQ47l0EqD67ug6MiQaKJv+sQu/vzJ78vXwxOpeHaa/
 /qlWppkpzC7j5ITIYiJW75AP6goAXbLO5DwSHGSWnaEnDM1x3Vq353XuYZ+7YMzgMzFp
 GRmSleiSb9XevjGYY5ZRmjCJ7p95oJ1WP4u4Efg9lSDB1tjq4M1Xb7vvzjWfyueSeT0V
 h0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765480377; x=1766085177;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YCmgL76a6bhZQ7y78yvYotS+8U6wO+0AkufFmlwHEEA=;
 b=vHOJj1Ol7PesIWzv1K6lgQUv4UQ9WTVJF0OptnOZ5WSOf5rmiHpH07PxTldREhQiGD
 qi4PtGGDeWYzvYdsiaQxoGwJKjoLzvEmYJMtqUo7stc6UiC7p9giAxQeNfaBb8/ukDYX
 2ekd66mMsyOGWadkJOQ6a2XjbPZ/4ByQY0zLU6Lrvx6NUMN0m14d7Y6XLCDQPLBc9gZ8
 /toC0IhsIet9rzCygMlANHfornUKZQiwWUdqP6ZeHUDVyGyK7mjFNYvyMbvsxAymOmjh
 Ms9RiSo8oBcAn6DeHxESsh/gti6cEH8chJ3aSfNTdCAMozO42rmrkreDbkxCvNs+rFz4
 MoBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqsdaEsBe7h2sunsPvxvV3gp6DDvCIUH4N+KvDMVf+zbuMNKOldb2kzhEDKBs0QF0InC73rutCuQ6A@nongnu.org
X-Gm-Message-State: AOJu0YxgMh3Z8ywlrrDZyHoBSv9/GuTUCSUq0EXlRGX9wtwCVe4lrWsX
 4slqT7guD0z7nV1Zua2cfPeDkiCfsujWCWIDEMLEJyhzBYVhENHUlOKGpDbh+ClGkPnnSS6w4Sg
 Mto6+ZFq46wrs30h+hMv0zuonIKPWbwiaF8WWEZBeTbStPKGf8o1x7Vku
X-Gm-Gg: AY/fxX42optbqF/8XFk2UdfT0NP8r4btoloXXVzdFRgxEF3vEBFfykotJ9eUp3YMQNI
 Gd9tW/IQmBHSt3cq8mkN6Yvs0m0VrMs3uY0o3d1S88iCAODaEGQuysFP6Yz2h43Gl0wvWiOKEhQ
 B+c7tt0kPh+9NuHHI9M9FAvKVkxo2RjNKNqIz2JY1hyB37SQULHLq6SL/McC5qc3EufS2+HbWcy
 7A1VbfMMeWYpusEEdqSmhkQVA2kHxsqilvOQJqu3oTiVfd/u2n7wHc8Em3tfjxGzitA7l4N8zqh
 bFcvrCNf4ssEJxtTdapErPY1KsUxz+zHZsxTOpLkOQZOq4oKb6cFLU6Yo7zCUGi6Lv2irTbP3n9
 PHK8=
X-Received: by 2002:a05:620a:1a8f:b0:8b2:efe7:d818 with SMTP id
 af79cd13be357-8ba39741480mr1077172185a.38.1765480376580; 
 Thu, 11 Dec 2025 11:12:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHU4JbFkzP2tZtpGGkZkJoI4h3sUkgq9vmbnxnTv7qwuQko6Ybc4Za/ryCjmZu7AiGRu6q52w==
X-Received: by 2002:a05:620a:1a8f:b0:8b2:efe7:d818 with SMTP id
 af79cd13be357-8ba39741480mr1077167485a.38.1765480376119; 
 Thu, 11 Dec 2025 11:12:56 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8bab5d3e2a1sm286243385a.42.2025.12.11.11.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 11:12:55 -0800 (PST)
Date: Thu, 11 Dec 2025 14:12:54 -0500
From: Peter Xu <peterx@redhat.com>
To: "Chaney, Ben" <bchaney@akamai.com>
Cc: "berrange@redhat.com" <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mark.kanda@oracle.com" <mark.kanda@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Hunt, Joshua" <johunt@akamai.com>, "Tottenham, Max" <mtottenh@akamai.com>,
 "Hudson, Nick" <nhudson@akamai.com>
Subject: Re: [PATCH] migration: cpr socket permissions fix
Message-ID: <aTsXtmUVP1TfRZaS@x1.local>
References: <20251120185733.141912-1-bchaney@akamai.com>
 <aSCOVNMJ-NK_9PuH@x1.local>
 <3DD5C44B-B1D5-4E5D-95F5-45DA855DDD39@akamai.com>
 <aTL2j7PB4--w68ir@x1.local>
 <85437E51-DEC6-4B79-8E5E-93B5D64D4CB2@akamai.com>
 <aThwdthSF30NygY4@x1.local>
 <3DC0D610-FDC3-47CC-83F0-BC9CD470E972@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3DC0D610-FDC3-47CC-83F0-BC9CD470E972@akamai.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Dec 11, 2025 at 06:42:05PM +0000, Chaney, Ben wrote:
> 
> 
> ﻿On 12/9/25, 1:55 PM, "Peter Xu" <peterx@redhat.com <mailto:peterx@redhat.com>> wrote:
> 
> > On Mon, Dec 08, 2025 at 07:32:41PM +0000, Chaney, Ben wrote:
> > >
> > > On 12/5/25, 10:13 AM, "Peter Xu" <peterx@redhat.com <mailto:peterx@redhat.com> <mailto:peterx@redhat.com <mailto:peterx@redhat.com>>> wrote:
> > >
> > >
> > > > Maybe you can stick with -incoming defer, then it'll be after step [3],
> > > > which will inherit the modified uid, and mgmt doesn't need to bother
> > > > monitoring.
> > >
> > > I tried this approach, but It doesn't look like it is possible to create the
> > > cprsocket later with -incoming defer.
> >
> >
> > You'll still need to chmod for the cpr socket. "defer" will still help the
> > main channel to be created with the uid provided.
> 
> Thanks for the pointers. I was able to get the incoming defer method
> working, but it has much worse performance than the other method.
> 
> Would you be open to a solution where we chown only the migration
> sockets, or would that run into similar concerns?

We can evaluate, but before that, could you explain your current solution
first?

And, what is the performance you mentioned here that is worse?

I at least didn't expect it to be downtime, because IIUC what your mgmt
needs to do is to chmod on the cpr channel first (during which migration
hasn't started), then chmod once more on the main channel after CPR channel
migrated and before main channel migration happens (during which VM should
be running on src), hence it should have nothing to do with downtime.

Thanks,

-- 
Peter Xu


