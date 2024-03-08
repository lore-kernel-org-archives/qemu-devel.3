Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACA3C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 10:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riXBs-0005pd-LV; Fri, 08 Mar 2024 05:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riXBp-0005of-Gj
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 05:10:57 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riXBl-0000be-L5
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 05:10:55 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TrhdJ5p9Nz6K61V;
 Fri,  8 Mar 2024 18:05:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 56344140DE1;
 Fri,  8 Mar 2024 18:10:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 8 Mar
 2024 10:10:48 +0000
Date: Fri, 8 Mar 2024 10:10:47 +0000
To: Hao Xiang <hao.xiang@bytedance.com>
CC: <farosas@suse.de>, <peter.maydell@linaro.org>, <peterx@redhat.com>,
 <marcandre.lureau@redhat.com>, <bryan.zhang@bytedance.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 11/20] util/dsa: Implement DSA task asynchronous
 submission and wait for completion.
Message-ID: <20240308101047.00001a2d@Huawei.com>
In-Reply-To: <20240104004452.324068-12-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
 <20240104004452.324068-12-hao.xiang@bytedance.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu,  4 Jan 2024 00:44:43 +0000
Hao Xiang <hao.xiang@bytedance.com> wrote:

> * Add a DSA task completion callback.
> * DSA completion thread will call the tasks's completion callback
> on every task/batch task completion.
> * DSA submission path to wait for completion.
> * Implement CPU fallback if DSA is not able to complete the task.
> 
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>

Hi,

One naming comment inline. You had me confused on how you were handling async
processing at where this is used.   Answer is that I think you aren't!

>  
> +/**
> + * @brief Performs buffer zero comparison on a DSA batch task asynchronously.
The hardware may be doing it asynchronously but unless that
buffer_zero_dsa_wait() call doesn't do what it's name suggests, this function
is wrapping the async hardware related stuff to make it synchronous.

So name it buffer_is_zero_dsa_batch_sync()!

Jonathan

> + *
> + * @param batch_task A pointer to the batch task.
> + * @param buf An array of memory buffers.
> + * @param count The number of buffers in the array.
> + * @param len The buffer length.
> + *
> + * @return Zero if successful, otherwise non-zero.
> + */
> +int
> +buffer_is_zero_dsa_batch_async(struct dsa_batch_task *batch_task,
> +                               const void **buf, size_t count, size_t len)
> +{
> +    if (count <= 0 || count > batch_task->batch_size) {
> +        return -1;
> +    }
> +
> +    assert(batch_task != NULL);
> +    assert(len != 0);
> +    assert(buf != NULL);
> +
> +    if (count == 1) {
> +        /* DSA doesn't take batch operation with only 1 task. */
> +        buffer_zero_dsa_async(batch_task, buf[0], len);
> +    } else {
> +        buffer_zero_dsa_batch_async(batch_task, buf, count, len);
> +    }
> +
> +    buffer_zero_dsa_wait(batch_task);
> +    buffer_zero_cpu_fallback(batch_task);
> +
> +    return 0;
> +}
> +
>  #endif
>  


