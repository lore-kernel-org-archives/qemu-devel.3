Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1556C88E70
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x66wJ-0004ks-V5; Mon, 14 Sep 2026 09:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x66wA-0004kE-D8
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 09:41:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x66w7-0004Do-MT
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 09:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789393290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z+2lONM2W8dOjvp1pSg9bMB7y5PdyR/g78esQN9p+Xo=;
 b=AOjr14VE+tWVO8b0fF8LbiKJuZq52xVT6u82nXKRncM3MecD7LB6Pj+MFnhZ45P0eYVZt7
 0g4F3KRot8LMk1AOoWeLofOHt16unfZRwmabyGZdRg4COifm/OZ7jn9AMGo+5lGHXoXBhe
 3cFjAmxr1RFoPsiqqmu5cItvCi9NqYQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-EIpUyIgbNXa0Z8We5EgZQA-1; Mon, 14 Sep 2026 09:41:27 -0400
X-MC-Unique: EIpUyIgbNXa0Z8We5EgZQA-1
X-Mimecast-MFC-AGG-ID: EIpUyIgbNXa0Z8We5EgZQA_1789393287
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90e8341cfb4so73117586d6.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 06:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789393287; x=1789998087; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z+2lONM2W8dOjvp1pSg9bMB7y5PdyR/g78esQN9p+Xo=;
 b=IPYYIflzh1CeRysDEb7hJjEpuAHr+bBJ9Feo8zA22+gIyrHa4j8HanyZnRWkRU40NL
 Ixv9GNU+4X4Uk9J3dqKnP+ajSE55yARSMi8cty2L9cQDA4zyp6QocT+MmPBJ8dq7SGfb
 xf7CyqrkJg2zta4BMVe/kOpU5V4eHoLMjBCbIF+vG9kOMVStA7ChUMuhNNhmQEa4qqjr
 SSWLn5eZSUYEiBVUnSqwyO1CB2bDpnI//UIyQe4uCE56IFdNjN6ZMs5e0MmHGnCLziI1
 PfuRk4OvpQkUk4rp2i9keI216wkgEaUiSEcFHYeBzjJpvy/0LTM4vhJMMtEFwLl7dYMG
 gAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789393287; x=1789998087;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z+2lONM2W8dOjvp1pSg9bMB7y5PdyR/g78esQN9p+Xo=;
 b=ApjG4XIDQINq81tCdxrEq8FPdFLyrPmu8rpNOB1xDPT8IlDzVBb7EkBe+n0cB9jn8y
 qB2i17KE8Aa4cEgDdGeYNMz9P7k5zdx3PLbLcvYBT1QlbMaln0z/obX9qXlJvTxCs8mo
 J4416HxfIAgyS6ag1AFIwItYkAsuaBAEc+hgZfLoNeE50FdruHVzlcIKMMWWy9RMkCS/
 EECPSL4ho64EDW4ijVtbIZiusYTHTgCBc6ohsmoef4Gd5sAhaWhZtGgAa5ELAX0zDZt1
 4rhk1+na/USDzKvO1EM8IBPvmMzASivQ/EUrmCFEWDcyVHOJHLRknxwoLxMwh7aFhT18
 Xocg==
X-Gm-Message-State: AFuF++kNn5bul/LKJo8lmNE8t81w5+wDjTn7B2w1BAhcZN9+fyjhO4yz
 WvUFhQVLlrKa37d6GK9iH0rgOa2CN/nY7UDt2vnWeEJdm7L6q8pbSku0LZukjqaJfrRnuHnaqQE
 HOiixkBfPcWtxB5VMfAQ+3+K/PfQiHHClocmYHflkhKnYyL3WhO8vqpM1
X-Gm-Gg: AYBFou0cag3XoTmFv9FvxfKf0SLpDZH2r6KkDFpiiBEltsRVcWIiuZ5kBeqDgAEZx8b
 Ut6XM5P8DZ/Ik7C/IZLcWdqojpk6fBoi9pi11/vG9SHiV1827Qo66kH4Ttm+EVGwPQmy84cEBzc
 xbMsyGPekoxvPYaKH+pPBxD/nyge/qaBtljHQD34or8xR5JashdslnsKYATx0doxCRYdHj36yRC
 ExhVjvOrX1gmazbUpTs2RyBxnHQQPQTE+WtrWmrNT/8kMXgt+Dloqzu5rvjiGTmut+HrBnrVSl9
 DANnIgjeDzPmfE1T4yDDMpXlx7zmud9UkzNbNBzFmzahf7zsOLTxHMCb1MkDSqM3anCJ
X-Received: by 2002:a05:6214:500c:b0:90e:893a:73dd with SMTP id
 6a1803df08f44-9122e5042e2mr41208346d6.16.1789393287110; 
 Mon, 14 Sep 2026 06:41:27 -0700 (PDT)
X-Received: by 2002:a05:6214:500c:b0:90e:893a:73dd with SMTP id
 6a1803df08f44-9122e5042e2mr41207966d6.16.1789393286549; 
 Mon, 14 Sep 2026 06:41:26 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-912334f822esm468416d6.25.2026.09.14.06.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 06:41:26 -0700 (PDT)
Date: Mon, 14 Sep 2026 09:41:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, farosas@suse.de,
 eblake@redhat.com
Subject: Re: [PATCH] qapi/migration: Make migration parameter @local
 consistently unstable
Message-ID: <aqf5e32Ba_Q_7wXw@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260912045350.2139416-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260912045350.2139416-1-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Sat, Sep 12, 2026 at 06:53:50AM +0200, Markus Armbruster wrote:
> @local is unstable in MigrationParameters, but not in
> MigrationParameter.  Fix the latter.
> 
> Fixes: c9affb8e9b (qapi: add local migration parameter)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

To avoid this in the future, can we further simplify MigrationParameter in
qapi/?  E.g. either dropping the @unstable completely (by mentioning in its
doc to reference MigrationParameters), or I also wonder if there is way we
can completely avoid some struct to be visible in doc, so we can drop it;
currently MigrationParameter still shows all fields "Not Documented".

Thanks,

-- 
Peter Xu


