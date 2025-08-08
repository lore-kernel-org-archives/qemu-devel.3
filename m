Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D546C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 15:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukPEd-0006U9-60; Fri, 08 Aug 2025 11:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ukPEb-0006NS-DB
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 11:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ukPEZ-0001GD-NL
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 11:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754667738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p8AVM9Iih8D+StVMZ3w+7yUhR5Jdlz3y7zoNHGyYXNQ=;
 b=e2xZcbsklYS0/Lf7wxxq2pfDXtSEBDlVPC0QbOzddIMLN+wyjHxyvypHsT2O1T8GFDWZ/3
 oMSfIc88ETBPC7FATVMi+sUAMtF7OUbVrmzTjH6EtfrXJSnqJn7q2RU8nE2/sSPt/RL5HG
 G1+wrX6nJjuQzAgUYKvGWGErJvqAXKM=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-y5mVYeM5OhWI8nkXb-Sn3w-1; Fri, 08 Aug 2025 11:42:17 -0400
X-MC-Unique: y5mVYeM5OhWI8nkXb-Sn3w-1
X-Mimecast-MFC-AGG-ID: y5mVYeM5OhWI8nkXb-Sn3w_1754667737
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-71bc21d27b2so32496277b3.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 08:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754667737; x=1755272537;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p8AVM9Iih8D+StVMZ3w+7yUhR5Jdlz3y7zoNHGyYXNQ=;
 b=e2Ugxi6LhdINzFRH8cQ2n6cHSS23DfS0Efwg8fpO9jCnjADuf8xp2E+EmRv7l0+un+
 e5/Sql+lKPO4iWPU+h1DUa6javhYWOjjZ96B/G2aAo9hnOzoTg0XObN3q/x0gKW1Dq0b
 7othKgHe9wOQrt1Y0h7hIWH+daV1S/zBr3osq3e4FJn2di0M0uCwwBm0kNt9y9qN14EX
 +Oxyu85Bb510CJ+KF3sR7uFChoG0FHt0g6NqiIzzELcQ66sbfraplicJ35j7tNhYC60v
 TeUvC4f1tW0dUSVyuCW/JwHR8d7LLFsIH8hf1Dgxl2D1HMFe6edmz6ypp67qQzOCr80N
 5Cdg==
X-Gm-Message-State: AOJu0YwEVkaGJL9/oxwZRv/xc1AYX6Hg5A/aF6/Rwd3sPVovO1LpBW5Q
 vPbD13WF6f+J9hycJLUTiPnt+OW8P+rm8O3c/I3vXe1Jw7srDjMLn157p75vYK7VDSUFwCA8r7f
 kpoJ5YLJExP8/SN5RWFx1QovdGTKMHTt51P5hcWL9oX5PyJXu6LaEPG8X
X-Gm-Gg: ASbGncsZ7I9XyKg67jGiKjSLrmHFnv5LZfV9nb/9SoscnTcQT+efqDiPiaEBUfTUp7l
 7hmZfvnGr1GzFmtKV31eRYHOKl+xrhLe3SxHHiKXl1fOBLTO2xAs8khycr+x1Biy5U+n7Yna05/
 1Hehvor8zh6Dmz+8KZBTgF1vZNMh91ySjhBRHVfrLhu8SyxfgOOFzkeG5OJi9p+Qzamc27b5fHZ
 kuHGKkuAct90cEKWuEpNv8oUbxdKry9NjyYT3Hejmuwg549/6yrvn1WttYYh+zJw1ay1gEQ6By2
 amUkQdKpXns/YqwTf31DoH+CuOwtB1oa
X-Received: by 2002:a05:690c:620b:b0:71b:da3a:93aa with SMTP id
 00721157ae682-71bf0e1448dmr42520067b3.27.1754667736899; 
 Fri, 08 Aug 2025 08:42:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr48aYuwYxxEUzolBKVf/RiIiz3J3uFKtF1fVcthWNRAvZ1GmgSjfzKFaoonmHrNiIdQh7Cg==
X-Received: by 2002:a05:690c:620b:b0:71b:da3a:93aa with SMTP id
 00721157ae682-71bf0e1448dmr42519727b3.27.1754667736437; 
 Fri, 08 Aug 2025 08:42:16 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71bfc653df6sm2238337b3.45.2025.08.08.08.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 08:42:15 -0700 (PDT)
Date: Fri, 8 Aug 2025 11:42:03 -0400
From: Peter Xu <peterx@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel <qemu-devel@nongnu.org>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] multifd: Make the main thread yield periodically to the
 main loop
Message-ID: <aJYay1BNkq8fiTVf@x1.local>
References: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
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

On Thu, Aug 07, 2025 at 10:41:17AM +0800, yong.huang@smartx.com wrote:
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b255778855..aca0aeb341 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1228,6 +1228,16 @@ void multifd_recv_sync_main(void)
>              }
>          }
>          trace_multifd_recv_sync_main_signal(p->id);
> +        do {
> +            if (qemu_sem_timedwait(&multifd_recv_state->sem_sync, 10000) == 0) {
> +                break;
> +            }
> +            if (qemu_in_coroutine()) {
> +                aio_co_schedule(qemu_get_current_aio_context(),
> +                                qemu_coroutine_self());
> +                qemu_coroutine_yield();
> +            }
> +        } while (1);

I still think either yank or fixing migrate_cancel is the way to go, but
when staring at this change.. I don't think I understand this patch at all.

It timedwait()s on the sem_sync that we just consumed.  Do you at least
need to remove the ones above this piece of code to not hang forever?

    for (i = 0; i < thread_count; i++) {
        trace_multifd_recv_sync_main_wait(i);
        qemu_sem_wait(&multifd_recv_state->sem_sync);
    }

>          qemu_sem_post(&p->sem_sync);
>      }
>      trace_multifd_recv_sync_main(multifd_recv_state->packet_num);
> -- 
> 2.27.0
> 

-- 
Peter Xu


