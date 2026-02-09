Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55799E81BDC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 15:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpTdI-0005wa-U0; Mon, 09 Feb 2026 10:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpTdG-0005u6-GC
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 10:57:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpTdD-0004hp-Iv
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 10:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770652617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DQRol2i0LgvUDUGrlNkabtYVpdZNVnlb/ATuhR1Lpro=;
 b=LhOO8mx3flQkef9RxhZwvLZEl6uNbI6wBbykhM2eURCTy7taRGDgkdjpVhbe1EbLJYPxFF
 gFEs1gn7D29OuTyV74i/8p8SJgTxRowCriMCbZxmeZ5DKXSKlLdosTDQ691pnQiOt0iYyy
 7zH2zT6m7fOCDdr6pArQVJdW75K3IXQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-RhqlM4PANYyyAY9WXgm-QA-1; Mon, 09 Feb 2026 10:56:56 -0500
X-MC-Unique: RhqlM4PANYyyAY9WXgm-QA-1
X-Mimecast-MFC-AGG-ID: RhqlM4PANYyyAY9WXgm-QA_1770652614
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-896fae40578so71729106d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 07:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770652614; x=1771257414; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DQRol2i0LgvUDUGrlNkabtYVpdZNVnlb/ATuhR1Lpro=;
 b=pMd7nN7+GR3Lwpu4iJqgeboED2w/Tt2o7uYOEKGlw8bOmyJBNm7wQWSIbC6bGua9ru
 D3+u/dwPMKZ/kzxmxuOXOIR369B5cxtdKQOAQMMopOffv9QFT+vPSMOg7cNPPtcLB8fV
 W3DYdEgGVLfw/1VRyqIakL+3eB15bOT1HhoK9nyTaEmZ+/GhiPLr3fsPciitc+Gfu0t8
 Vt2KCZZiyNOJfkeTf9wrXNNcOsSepe0ViioXs7M83brCwv0he5W3/G7EQjRzWQbxn7M6
 EjyQCTpoxWxlQnbv0ZD65IBNaGUNIVclAetA95c/W/ar3anRG43MMgNLf+BGkYfxwa/C
 2jNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770652614; x=1771257414;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQRol2i0LgvUDUGrlNkabtYVpdZNVnlb/ATuhR1Lpro=;
 b=cuydHvIWwTzx6rhYjeBNvD353r2YjWxjx1+4XVlaJ4cQg36eWnkjygf6HKKAYrrkgC
 Bxlf1kV7n8MEWKRYXxC8t3RLhtxpoDXJ6wgMuisBLrlcKSZltBSdTaxX3AdIr9xJutnE
 rTjjRq74FXYp9aE1RJxFQMStP+1a5DTESenDr1/yGWvTNxuCCwywX+6qdZiCMZDpz2Jy
 3hhmoAvOCKWvpw9MjbfoaTQYpWCc5LGJvsfQKYRV59n0nfhKRfO+icWWa8uPIgO6SJv9
 hSLY45C6TtD/02SXbGa4BQPWnGhk59mf5sNQ8XDZ7MDEGVyyRhDxnlR0qTtHQHzYTr5x
 22VQ==
X-Gm-Message-State: AOJu0YzhoaZT3H718dYRHAj226/zkrp7GEE9oyCx12Qw35hwflx152RM
 ObTMQUxtxvakYvqO+Q45ErDSzW9EyQhdNp4tl2/4/ZuXfKup0BN9tvhJ6zfS+WXqp39+bJTKXLj
 2dZcWZ+HQ4/kYoU0V2ErHRq/2AgbrmTLdtEVsyz6HLwcmswT5lPodkeqf
X-Gm-Gg: AZuq6aJ9fszDDlGEnUCr9HgyZJh0o5vUZdC40xUVDXsCl5KDEAGo5K/FNfXo5E2ot5Z
 HAu7H6s4esCuIbd24Z8tbzCsHiBg25w4kR1U/xea02kW9R2o7b8hOLdMM22ghmg3OSjfW04W8z3
 3pwpGV9tBTdTsDbwvJ9N63lx29RJ024d+7Vo6NFlrfDdstBwnQ7G9utUhd7u/nzDz1NAtthUGHc
 2XJg+1Zln9zaINmi/PXMpTgabzrPEiJStHnJ3OfN8f3hSjBQCxo3UVfbT44J8CdORYiYVclBy4r
 lx6/XfH0DPZgg11IPkWR+xVA/cVJT4yPojSho78vz30GYdUNk1fmexOI3xIXi4yCj7fxabk77KV
 zjvI=
X-Received: by 2002:a05:6214:2a48:b0:895:4cc2:8bfc with SMTP id
 6a1803df08f44-8954cc28daemr94543156d6.14.1770652614265; 
 Mon, 09 Feb 2026 07:56:54 -0800 (PST)
X-Received: by 2002:a05:6214:2a48:b0:895:4cc2:8bfc with SMTP id
 6a1803df08f44-8954cc28daemr94542876d6.14.1770652613864; 
 Mon, 09 Feb 2026 07:56:53 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf9fdfa1bsm839943585a.45.2026.02.09.07.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 07:56:53 -0800 (PST)
Date: Mon, 9 Feb 2026 10:56:52 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v5 12/16] migration-test: Add COLO migration unit test
Message-ID: <aYoDxFoWD5_XzNoW@x1.local>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
 <20260203-colo_unit_test_multifd-v5-12-57508b7389f6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260203-colo_unit_test_multifd-v5-12-57508b7389f6@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Feb 03, 2026 at 11:15:18AM +0100, Lukas Straub wrote:
> +void migration_test_add_colo(MigrationTestEnv *env)
> +{
> +    /*
> +     * COLO crashes with TCG accelerator.
> +     */
> +    if (!env->has_kvm) {

Lukas,

Per the discussion here:

https://lore.kernel.org/qemu-devel/20260206201050.6a692a34@penguin/

Do you think we can drop this line here with some proper fix in the code
instead?

> +        g_test_skip("COLO requires KVM accelerator");
> +        return;
> +    }

The test itself looks all good here otherwise. If this is the only reason
to respin, we can also do it as a follow up.

Thanks,

-- 
Peter Xu


