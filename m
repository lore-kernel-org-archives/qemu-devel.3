Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402C6C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2SpP-0006qd-1N; Fri, 04 Sep 2026 08:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2SpM-0006qO-SJ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2SpK-0006xn-L4
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788524122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GHwoYM+E2dA6E9QbMnNSR07EnnbRZuZkZPDUDnsuAk8=;
 b=WX+hWLA4LEeWIM2hmaEmY7GoHs3ZfDWeF633vwUc5dUAl+jv6T3oS2Rd0AEcSxsKPed98u
 vlZHeyRh9zfQ91DI6JC4i3/20+OhyjDxu2K+PdtjBV9TkGlTxtBr/dklsC4Z7WZJZ2xC8w
 LulvbfQRJuhB0jeAIIaXG5HocQCvdTg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-BfM4bPrjPH2YPrVm7_OQYQ-1; Fri, 04 Sep 2026 08:15:21 -0400
X-MC-Unique: BfM4bPrjPH2YPrVm7_OQYQ-1
X-Mimecast-MFC-AGG-ID: BfM4bPrjPH2YPrVm7_OQYQ_1788524121
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e4f946461so186378985a.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788524121; x=1789128921; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GHwoYM+E2dA6E9QbMnNSR07EnnbRZuZkZPDUDnsuAk8=;
 b=RD75kqZ1C+67ip3xOs+lXglHbIzXEgX/YFLUZghzaS8xx5b7xPDgYC6lWaf122dHfO
 nKms0j/Ia+NH7hx1JS6wKFKAo/ErdzHm76bSG3g7bzY6WjpFjdcwSZBESJiWdWZ84k7/
 VVQjlqNpt0X2fGhxpiyAFyLabjxllokVBxtGpyw5xUC2/gWif1I7K9bWODzZ5vRRZH78
 EZiAW8dGToSYsTdJO+Iek4bCqzoYqfll4R8Mcas6H3k+OKbcG8sU19oIqHzQyINu5g3z
 Ap21PjZZIDbHVW5oxQwv2+rf5W+aeIjbLQzQbxjhN+mP/Tua0GE43b9i4RiWR1JHrhNd
 LmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788524121; x=1789128921;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GHwoYM+E2dA6E9QbMnNSR07EnnbRZuZkZPDUDnsuAk8=;
 b=mtatHrY7JlV1YUfIvS0XxNMVbpdG/xY24lDF2LAT5hFwqCvI/l7hnT89IfRhVYyMgw
 KPnJnVCqXDbN94KsSOjJplUI+T46e+o5PBkMXb3Dk3Twyh9fLfY1Inid6S4mOngfrydO
 HwAA4PRhAYTMDsWugdbcHXjyuyyl1oBZuFVc+VezGhs+7aUrWdnbZzbmaLR36UaBEJuI
 /lwVr/CbcI5mZ9BvVffLPvx45B+IEBlFh7uHC5nC9YQ1UTVKfOPTH8U+cjOj6QUUCLVU
 tvWAUG1lYzWXoA2Ij0QP/W8I3dIeoOQGkn9VgjucvjELX9enqjYb2TKvAUrnmdMffm2J
 WY+w==
X-Gm-Message-State: AFuF++nXDNA9xh480DclE8f1i8uQpkVJPY7xIieCoPPUurj1BBOrLm67
 Mq+Uy4BC4tzUTIGtCr+V7e3Pic/ZZ2aaKzs7JVR3EQ2CfAM6QfQ6wd/WM0kyAFOdlLVXBChlChu
 U3esIHLtfVh0z2p4zKTQP9W2DBXSWmF84KK+vsfOIurzZlrgM4MOwj31I
X-Gm-Gg: AYBFou2o3ReV3Xp2c07rbUhYQRz6uM7oVEtFFhi4nasbn5j+HVGZ+ViAVU/+zDtEjBO
 5sV0Y61ka2Q7vHzEueOYgLuZLC76jsNzShP5FM25gKutuQFVF/TzkNRzon0mgWgPTNI6pK0F5XQ
 pbLl8icXflWANyZOusYE18AKdxZ6IlwG84YLA/WPkrV+OLGHmREHjGWdfq+FplRlSwudw2duPiH
 PztNScYb1UCUjcVe3kHRUyhHCTy28YhzXh9wF2WsYNm+DGO17rHZyKddIXkoM83kDI95r35dHMt
 epbzWjtT1YARPYgqUkH37gTXwifEEZafIFnDpipGOEEzFc+vUjzS88BPPWz4PdaWyrLr
X-Received: by 2002:a05:620a:3f0a:b0:934:9639:3a4 with SMTP id
 af79cd13be357-939804af893mr376636185a.41.1788524120564; 
 Fri, 04 Sep 2026 05:15:20 -0700 (PDT)
X-Received: by 2002:a05:620a:3f0a:b0:934:9639:3a4 with SMTP id
 af79cd13be357-939804af893mr376629885a.41.1788524119967; 
 Fri, 04 Sep 2026 05:15:19 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fb62710sm201122685a.28.2026.09.04.05.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:15:19 -0700 (PDT)
Date: Fri, 4 Sep 2026 08:15:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 17/18] migration: Remove s->capabilities
Message-ID: <apq2S1GA2NO60Sir@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-18-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902221547.1812481-18-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 02, 2026 at 07:15:45PM -0300, Fabiano Rosas wrote:
> @@ -1555,6 +1509,9 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>           !is_power_of_2(params->x_rdma_chunk_size))) {
>          error_setg(errp, "Option x_rdma_chunk_size expects "
>                     "a power of 2 in the range 1MiB to 1024MiB");

Miss a return here?  Can keep the R-b with this fixed.

> +    }
> +
> +    if (!migrate_caps_check(params, errp)) {
>          return false;
>      }

-- 
Peter Xu


