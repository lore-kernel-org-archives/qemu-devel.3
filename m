Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51525D3ABCE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 16:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAXkT-0002V8-LD; Mon, 11 Nov 2024 11:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAXkQ-0002UD-5G
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 11:58:43 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAXkO-000710-E6
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 11:58:41 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so60026505e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 08:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731344318; x=1731949118; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8AmOQtOa2eUZ3qI/PBB2peqkJbi3LdI1LBE4863rqZ4=;
 b=q24S8zNTvmo3C9ZRDiR33zHSSvwTjVUXjVvDNahRK/THMLRJ5rQJJczIOHyndJkAEc
 giE5hisNo6++vDJzO6bhlaQYgyTlaz9Q0z6kMayC9YJYvDrs6nhI/4MUoaiOMCC3xZsE
 TM83/SapIqEX6Dm8lDu5Hw1fOSjMJYnXiGmc/r/xViYxFCs+c6DumpAFJn4WnkA6nsvK
 +/9IIhKYB6JHVK0md+uT0ALbOPyIK1z8CTXFS334R7jwIpkt6XUsqS/CUcNtpM5jcGzF
 wj18GNQMkqLpGYPO147ydtITaxcyDqTCPf9nbbq6yXxYo9oUKBB+LCsyrB6btotXzSx9
 7a6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731344318; x=1731949118;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8AmOQtOa2eUZ3qI/PBB2peqkJbi3LdI1LBE4863rqZ4=;
 b=xVYiGLYoJ2699XLs4OBzxLtQNQxUZYlBA8HJBXsN16OFiGcGPLE4mpMIQ1xCglrE8H
 /V9rvVlfw/Jq6YGqNumNuhurDf70xOjtoWBJ46P7pO7nML9M1S7a/Jdv8zGHbz/pA10q
 TESHOp+AivDOGHcql3cWstHc3IPdg0wxZAGJ59rBDHBp2pQaDkWMoxMZjktrrmgB7cmn
 cIcZR7gfLDJKDp17b0CxV7rZIeR2D7hSvMtQ+UE1G0ySnJvFiKFy9ISQaMpX747Au2Sn
 e/DsuBGB7aPgP7afxFiBR3rUc2NarSe3+xwXKLuksQNxg69dzW+w8R7JhW/tXHtEGOWx
 ZNHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVroG4Fqo2yWpfrUEciAzHMGSOfJ60HsJuGpsQpCpFDH4u8kO60Q0HZZuN6Al8/Ck8XIAchN92Sd7/y@nongnu.org
X-Gm-Message-State: AOJu0YyponNphefchYBf1aZez3OzqFf3dEt4GzyimU4Hn0JdvynpDUPj
 X4oJa/+dO6V03RQp0FNCO19VNhvFq3QbdK7RBQ4+KQmsKnYTCmaaz0VUk3wLklg=
X-Google-Smtp-Source: AGHT+IHbcRxfe9BdF4KZT+b2ny9kLf6U0vZd6f6Fh3i6WmZxtUuNzXMq9g/TN4a//7SY5/ubyVNTdg==
X-Received: by 2002:a05:600c:4f4a:b0:431:9a26:3cf6 with SMTP id
 5b1f17b1804b1-432b74fed4amr149921835e9.4.1731344318392; 
 Mon, 11 Nov 2024 08:58:38 -0800 (PST)
Received: from [192.168.69.126] (vau06-h02-176-184-43-163.dsl.sta.abo.bbox.fr.
 [176.184.43.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b3505sm215035645e9.15.2024.11.11.08.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 08:58:37 -0800 (PST)
Message-ID: <aeef7f22-1102-4d03-a473-564d65e29892@linaro.org>
Date: Mon, 11 Nov 2024 17:58:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix leak in send_qmp_error_event
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
References: <20241111145214.8261-1-farosas@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241111145214.8261-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 11/11/24 14:52, Fabiano Rosas wrote:
> ASAN detected a leak when running the ahci-test
> /ahci/io/dma/lba28/retry:
> 
> Direct leak of 35 byte(s) in 1 object(s) allocated from:
>      #0 in malloc
>      #1 in __vasprintf_internal
>      #2 in vasprintf
>      #3 in g_vasprintf
>      #4 in g_strdup_vprintf
>      #5 in g_strdup_printf
>      #6 in object_get_canonical_path ../qom/object.c:2096:19
>      #7 in blk_get_attached_dev_id_or_path ../block/block-backend.c:1033:12
>      #8 in blk_get_attached_dev_path ../block/block-backend.c:1047:12
>      #9 in send_qmp_error_event ../block/block-backend.c:2140:36
>      #10 in blk_error_action ../block/block-backend.c:2172:9
>      #11 in ide_handle_rw_error ../hw/ide/core.c:875:5
>      #12 in ide_dma_cb ../hw/ide/core.c:894:13
>      #13 in dma_complete ../system/dma-helpers.c:107:9
>      #14 in dma_blk_cb ../system/dma-helpers.c:129:9
>      #15 in blk_aio_complete ../block/block-backend.c:1552:9
>      #16 in blk_aio_write_entry ../block/block-backend.c:1619:5
>      #17 in coroutine_trampoline ../util/coroutine-ucontext.c:175:9
> 
> Plug the leak by freeing the device path string.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   block/block-backend.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 85bcdedcef..a3b7f00188 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -2134,13 +2134,14 @@ static void send_qmp_error_event(BlockBackend *blk,
>   {
>       IoOperationType optype;
>       BlockDriverState *bs = blk_bs(blk);
> +    char *path = blk_get_attached_dev_path(blk);

Preferably using g_autofree,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   
>       optype = is_read ? IO_OPERATION_TYPE_READ : IO_OPERATION_TYPE_WRITE;
> -    qapi_event_send_block_io_error(blk_name(blk),
> -                                   blk_get_attached_dev_path(blk),
> +    qapi_event_send_block_io_error(blk_name(blk), path,
>                                      bs ? bdrv_get_node_name(bs) : NULL, optype,
>                                      action, blk_iostatus_is_enabled(blk),
>                                      error == ENOSPC, strerror(error));
> +    g_free(path);
>   }
>   
>   /* This is done by device models because, while the block layer knows

Having read this patch, we should improve the doc for this methods.
I'll post the following later:

-- >8 --
diff --git a/include/sysemu/block-backend-io.h 
b/include/sysemu/block-backend-io.h
index d174275a5c..ba8dfcc7d0 100644
--- a/include/sysemu/block-backend-io.h
+++ b/include/sysemu/block-backend-io.h
@@ -32,6 +32,13 @@ void blk_set_allow_aio_context_change(BlockBackend 
*blk, bool allow);
  void blk_set_disable_request_queuing(BlockBackend *blk, bool disable);
  bool blk_iostatus_is_enabled(const BlockBackend *blk);

+/*
+ * Return the qdev ID, or if no ID is assigned the QOM path,
+ * of the block device attached to the BlockBackend.
+ *
+ * The caller is responsible for releasing the value returned
+ * with g_free() after use.
+ */
  char *blk_get_attached_dev_id(BlockBackend *blk);

  BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
diff --git a/block/block-backend.c b/block/block-backend.c
index 85bcdedcef..6128012953 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1019,6 +1019,10 @@ DeviceState *blk_get_attached_dev(BlockBackend *blk)
      return blk->dev;
  }

+/*
+ * The caller is responsible for releasing the value returned
+ * with g_free() after use.
+ */
  static char *blk_get_attached_dev_id_or_path(BlockBackend *blk, bool 
want_id)
  {
      DeviceState *dev = blk->dev;
@@ -1033,15 +1037,15 @@ static char 
*blk_get_attached_dev_id_or_path(BlockBackend *blk, bool want_id)
      return object_get_canonical_path(OBJECT(dev)) ?: g_strdup("");
  }

-/*
- * Return the qdev ID, or if no ID is assigned the QOM path, of the block
- * device attached to the BlockBackend.
- */
  char *blk_get_attached_dev_id(BlockBackend *blk)
  {
      return blk_get_attached_dev_id_or_path(blk, true);
  }

+/*
+ * The caller is responsible for releasing the value returned
+ * with g_free() after use.
+ */
  static char *blk_get_attached_dev_path(BlockBackend *blk)
  {
      return blk_get_attached_dev_id_or_path(blk, false);
---

