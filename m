Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D22BE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 16:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ8AF-0006Ys-Fq; Tue, 24 Dec 2024 11:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQ8AE-0006YJ-Fw
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:53:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQ8AB-0007Dh-7L
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735059220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TB0fo/bVbzitc6+x+UIF8h0UO0oa2vNO47I5mwKzLhQ=;
 b=HNat2IunsgALVcvvWD6IWm4DTrnEXW5nkt3PoNd5vPGTP4YudC4f0unqQSqS1rk0DXmXVq
 gX+yD5B+zsEq+pGo0umSknyJtaD93S2bIN7QRxtZlC5Fp25bOCbaRcu5s3OrhspOXGsmX+
 VtICi4crZykuU6FwifTb4IJkAen6ffY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-P-SpikLbP86YyxOrhoq1Zw-1; Tue, 24 Dec 2024 11:53:35 -0500
X-MC-Unique: P-SpikLbP86YyxOrhoq1Zw-1
X-Mimecast-MFC-AGG-ID: P-SpikLbP86YyxOrhoq1Zw
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-468f7e0aef7so117591491cf.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 08:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735059215; x=1735664015;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TB0fo/bVbzitc6+x+UIF8h0UO0oa2vNO47I5mwKzLhQ=;
 b=gZ8bHMrzWdGvo3AvR+GWlGcp+pR8pm2R0YKd6Kz31b22vyUBD+7f6ly5TyrWWjzUfa
 kVVS8MRS0yNuxTYM/TzVHGuZCAZTPoUdu9rHt7Ggg1jvEjOkzAD3e5rkjJXMaG8vC7er
 Prpop8i5Ds/0IzLA1eMsg2nuGkI/NmPk7/dQfhvMS0HAKH+/+sTi1cvHqXHEvtSf5yFv
 LK0cheRIG/mS87RfGQnuQrXPxutISIxVBUIMkHxaDvDMJr6Ua3JMU5NsKfc/MTkzw8KT
 Ol6SNSrLZF8RGGYGCNUeTLxMRItB6cxl2wNCT96WG5V0VuFVJ6ihoEQl1u2CHPgk/uT0
 eTSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUde0w+aEn/HQUqAyd1mPt48WGgQDdccLxkdEGXsYhyy/9Gx8/JvrWTek/jOiulg5mWV9B3nerm2Ezm@nongnu.org
X-Gm-Message-State: AOJu0YxryfTlVmN0/m4edGf6MzSzVfqT02TQZn+6SkuGBzrzB0Y9LIK5
 upI3Sj5j0nFZq41coNU7cIwvt0LiFISqWtD66sbQ6reBSI3wXYJ/fbcfuMnqthBr96/lcl9sjMg
 3T3PvuARpglY0ZGHkpd0sK1kSfpESzpNfZT7GKKi5GL2UHJZASULe
X-Gm-Gg: ASbGnctMyaWh4KV2f+ZJOjaV6kIyFgv1mG3lC5b99CYJpVbNoDeH3offyKABulbIHPX
 eerrDeG13fw4RZMfwOog73IOLx1ggnqtlpilCX31LU/BS3eAe684h7wP+Eo5NA6Kl0fjlxkpZNW
 qzF5OfREBdtSSn4x9gbgUJjlo0iL6qoNKc0u8mexFGUSAhzo6GGlCi0oiPc+oCawGkCLDUinrYP
 b0TAsPJ5aRQN/5Agr3ZLpW54pz8BDdlQ3iLYMwwUeLA5ApQLDuR8IHbcXMwt76KXRjs7s29SXct
 j0ya4L0sX+HhPn1D0Q==
X-Received: by 2002:ac8:59c4:0:b0:467:6b59:423 with SMTP id
 d75a77b69052e-46a4a9a4378mr298371611cf.55.1735059215376; 
 Tue, 24 Dec 2024 08:53:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTILSqaEY6rvfn2fdBhUTINu9nd3gotUfu08KCQJrtNbz8nNa9gbK06McsXuV+dUYfnF4dYA==
X-Received: by 2002:ac8:59c4:0:b0:467:6b59:423 with SMTP id
 d75a77b69052e-46a4a9a4378mr298371351cf.55.1735059215059; 
 Tue, 24 Dec 2024 08:53:35 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2bc18dsm481686185a.22.2024.12.24.08.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 08:53:34 -0800 (PST)
Date: Tue, 24 Dec 2024 11:53:31 -0500
From: Peter Xu <peterx@redhat.com>
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 Shivam Kumar <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [PATCH v8 08/12] migration/multifd: Add new migration option for
 multifd DSA offloading.
Message-ID: <Z2rnC8HHVOMkie9h@x1n>
References: <20241204021142.24184-1-yichen.wang@bytedance.com>
 <20241204021142.24184-9-yichen.wang@bytedance.com>
 <CAHObMVaaLAJZcQbDYKBr0nddvKeY1L=Nf8HjqN7CNd3Z3chfaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHObMVaaLAJZcQbDYKBr0nddvKeY1L=Nf8HjqN7CNd3Z3chfaA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 23, 2024 at 11:11:46PM -0800, Yichen Wang wrote:
> > @@ -563,6 +572,15 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
> >          p->has_x_checkpoint_delay = true;
> >          visit_type_uint32(v, param, &p->x_checkpoint_delay, &err);
> >          break;
> > +    case MIGRATION_PARAMETER_ACCEL_PATH:
> > +        p->has_accel_path = true;
> > +        char **strv = g_strsplit(valuestr ? : "", " ", -1);
> > +        strList **tail = &p->accel_path;
> > +        for (int i = 0; strv[i]; i++) {
> > +            QAPI_LIST_APPEND(tail, strv[i]);
> > +        }
> > +        g_strfreev(strv);
> > +        break;
> 
> I am doing my final testing, and seeing a new issue for above. This
> code doesn't really work, because strv is freed and all contents after
> the string split are gone. So here is what I am thinking:
> 
> 1. This is supposed to be an easy visit_type_strList(v, param,
> &p->accel_path, &err), but it actually doesn't work. The code will
> throw:
> qemu-system-x86_64.dsa: ../../../qapi/string-input-visitor.c:343:
> parse_type_str: Assertion `siv->lm == LM_NONE' failed.
> when you are doing "migrate_set_parameter accel-path
> dsa:/dev/dsa/wq0.1" from HMP.

IIUC that's for JSON only.

> 
> 2. If I remove the g_strfreev(strv), things are working perfectly. But
> I am worried about the memory leak here. As technically if you keep
> doing migrate_set_parameter for say 1 million times, memory will be
> exhausted.

Right, better not leak mem.  Can you dup the str when constructing the
artifact?  I mean something like:

-   QAPI_LIST_APPEND(tail, strv[i]);
+   QAPI_LIST_APPEND(tail, g_strdup(strv[i]));

Thanks,

-- 
Peter Xu


