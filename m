Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B0FC27C55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 02:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGrVc-000087-Gk; Mon, 10 Jun 2024 22:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sGrVa-000076-0h
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 22:45:14 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sGrVU-0008Vb-Bf
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 22:45:13 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57a44c2ce80so573949a12.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 19:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1718073903; x=1718678703; darn=nongnu.org;
 h=cc:to:subject:message-id:date:user-agent:mime-version:from
 :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to;
 bh=begzroFEhTvwDpY/3QWdJYqDoMMQuKwsImqEEFGVag4=;
 b=EE9lQDwYK9NqvcHDC0jxyT2bCz+RdeNKjfzhf1027H27rxHBDx2KE+nttrqDvI31dv
 NRNNeLdu5fhkvcXb2Dgrnao65QVGUNE77Xzn5VWpw+/iMDq+IxmuNp5x5QynjrqJhrnA
 ciyaxPNLZwh9x5SAn78c84R/TNc5ShW0HK0aF2GoJxgo+8tLu0e+EzxYwOTqlnGPAMIU
 D42/MvfXa9a2flu0ReBfhaaF4vFVihlW+a/B4gvCuFsCwHTIDavnmJWA0kuWHPgEo+Ua
 fYleiQBxAZ+jxu0ltA+RCURwvPsfQTsRRB/OfsbgCGXs1OpFVBtEZMlzdYMK5Sd4V9Ej
 HMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718073903; x=1718678703;
 h=cc:to:subject:message-id:date:user-agent:mime-version:from
 :references:in-reply-to:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=begzroFEhTvwDpY/3QWdJYqDoMMQuKwsImqEEFGVag4=;
 b=F+e4E7c04LxTqehkZu8oMwHYP71YZK2Yw95A/mFLANSV1K1skEnFuCl6LX4fws9wHE
 30RYaV/v9JzWo4TTpvRTgwf2i+nxaQEmsjnGrL4u/yXaLO0GVNN1UU6+TL8nYIseOnfI
 PKnF4PjM46ufC8ZV6OYoX9geSF9V8Z3zxggEg17HhC9CLR1xWnLBSDvv7EOYsx6dmHLb
 C/d32m1CJJMXSYVU1W+FY4RQ4CSaByhVsY2GjEFBcFdPoQIcqra7lJtGHuYC++3BeL/Z
 IvGizc1qxSfp8NEmyB2ExihruYWPkhwmYt4m4ajUedhUKM7ngzzuP4hrcAoi25g6ywUf
 hpmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxvMOavsBCE6fMxYAf4f13/4BYN5CIfrVW3yTXyvCMSrSOcmNAaIdI7rDZIqEgHQeR96O+vWzwXUtVc+y4c+hTeQYrrq8=
X-Gm-Message-State: AOJu0Ywer4waTPJQC0Xb9tdmWAnxRkZdQ+37lwAgiYLtKV4u+EWx4FUS
 eFOnXztU7oNYzM670IoxUwwNXd4+egVrJB8L2178SyHxxoUi43xLYySLtJDN0biWMpK/Z+pMkId
 kI5wnMExNVHyffVRUDTaWeEhu6ZqfUkAuCHByeQ==
X-Google-Smtp-Source: AGHT+IG3D1J/gNKMF4GhF+AwM0stIvcvYTLmf59dP3/5aJSE5f75ZU4t6AFRXnOe1N5FyGWKRZGtyasquTqD+rKVLKw=
X-Received: by 2002:a50:9991:0:b0:57c:947c:f9cf with SMTP id
 4fb4d7f45d1cf-57c947d0061mr129197a12.11.1718073902945; Mon, 10 Jun 2024
 19:45:02 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 10 Jun 2024 19:45:02 -0700
In-Reply-To: <20240610172643.GB334653@fedora.redhat.com>
References: <20240606122444.2914576-1-luchangqi.123@bytedance.com>
 <20240606122444.2914576-2-luchangqi.123@bytedance.com>
 <20240610172643.GB334653@fedora.redhat.com>
From: =?UTF-8?B?5Y2i6ZW/5aWH?= <luchangqi.123@bytedance.com>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
X-Original-From: =?UTF-8?B?5Y2i6ZW/5aWHIDxsdWNoYW5ncWkuMTIzQGJ5dGVkYW5jZS5jb20+?=
Date: Mon, 10 Jun 2024 19:45:02 -0700
Message-ID: <CAO5cSZBqun9mKZ-fsFSikbdvWF9Z8jPV-tQTbzgcqOXndogHdQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 01/10] block: add persistent reservation
 in/out api
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com, 
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org, its@irrelevant.dk, 
 foss@defmacro.it, philmd@linaro.org, pizhenwei@bytedance.com
Content-Type: multipart/alternative; boundary="000000000000af0140061a944049"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--000000000000af0140061a944049
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for your advices! I will add it.

On 2024/6/11 01:26, Stefan Hajnoczi wrote:
> On Thu, Jun 06, 2024 at 08:24:35PM +0800, Changqi Lu wrote:
>> Add persistent reservation in/out operations
>> at the block level. The following operations
>> are included:
>>
>> - read_keys: retrieves the list of registered keys.
>> - read_reservation: retrieves the current reservation status.
>> - register: registers a new reservation key.
>> - reserve: initiates a reservation for a specific key.
>> - release: releases a reservation for a specific key.
>> - clear: clears all existing reservations.
>> - preempt: preempts a reservation held by another key.
>>
>> Signed-off-by: Changqi Lu
>> Signed-off-by: zhenwei pi
>> ---
>> block/block-backend.c | 397 ++++++++++++++++++++++++++++++
>> block/io.c | 163 ++++++++++++
>> include/block/block-common.h | 40 +++
>> include/block/block-io.h | 20 ++
>> include/block/block_int-common.h | 84 +++++++
>> include/sysemu/block-backend-io.h | 24 ++
>> 6 files changed, 728 insertions(+)
>>
>> diff --git a/block/block-backend.c b/block/block-backend.c
>> index db6f9b92a3..6707d94df7 100644
>> --- a/block/block-backend.c
>> +++ b/block/block-backend.c
>> @@ -1770,6 +1770,403 @@ BlockAIOCB *blk_aio_ioctl(BlockBackend *blk,
unsigned long int req, void *buf,
>> return blk_aio_prwv(blk, req, 0, buf, blk_aio_ioctl_entry, 0, cb,
opaque);
>> }
>>
>> +typedef struct BlkPrInCo {
>> + BlockBackend *blk;
>> + uint32_t *generation;
>> + uint32_t num_keys;
>> + BlockPrType *type;
>> + uint64_t *keys;
>> + int ret;
>> +} BlkPrInCo;
>> +
>> +typedef struct BlkPrInCB {
>> + BlockAIOCB common;
>> + BlkPrInCo prco;
>> + bool has_returned;
>> +} BlkPrInCB;
>> +
>> +static const AIOCBInfo blk_pr_in_aiocb_info = {
>> + .aiocb_size = sizeof(BlkPrInCB),
>> +};
>> +
>> +static void blk_pr_in_complete(BlkPrInCB *acb)
>> +{
>> + if (acb->has_returned) {
>> + acb->common.cb(acb->common.opaque, acb->prco.ret);
>> + blk_dec_in_flight(acb->prco.blk);
>
> Did you receive my replies to v1 of this patch series?
>
> Please take a look at them and respond:
>
https://lore.kernel.org/qemu-devel/20240508093629.441057-1-luchangqi.123@bytedance.com/
>
> Thanks,
> Stefan
>
>> + qemu_aio_unref(acb);
>> + }
>> +}
>> +
>> +static void blk_pr_in_complete_bh(void *opaque)
>> +{
>> + BlkPrInCB *acb = opaque;
>> + assert(acb->has_returned);
>> + blk_pr_in_complete(acb);
>> +}
>> +
>> +static BlockAIOCB *blk_aio_pr_in(BlockBackend *blk, uint32_t
*generation,
>> + uint32_t num_keys, BlockPrType *type,
>> + uint64_t *keys, CoroutineEntry co_entry,
>> + BlockCompletionFunc *cb, void *opaque)
>> +{
>> + BlkPrInCB *acb;
>> + Coroutine *co;
>> +
>> + blk_inc_in_flight(blk);
>> + acb = blk_aio_get(&blk_pr_in_aiocb_info, blk, cb, opaque);
>> + acb->prco = (BlkPrInCo) {
>> + .blk = blk,
>> + .generation = generation,
>> + .num_keys = num_keys,
>> + .type = type,
>> + .ret = NOT_DONE,
>> + .keys = keys,
>> + };
>> + acb->has_returned = false;
>> +
>> + co = qemu_coroutine_create(co_entry, acb);
>> + aio_co_enter(qemu_get_current_aio_context(), co);
>> +
>> + acb->has_returned = true;
>> + if (acb->prco.ret != NOT_DONE) {
>> + replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
>> + blk_pr_in_complete_bh, acb);
>> + }
>> +
>> + return &acb->common;
>> +}
>> +
>> +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
>> +static int coroutine_fn
>> +blk_aio_pr_do_read_keys(BlockBackend *blk, uint32_t *generation,
>> + uint32_t num_keys, uint64_t *keys)
>> +{
>> + IO_CODE();
>> +
>> + blk_wait_while_drained(blk);
>> + GRAPH_RDLOCK_GUARD();
>> +
>> + if (!blk_co_is_available(blk)) {
>> + return -ENOMEDIUM;
>> + }
>> +
>> + return bdrv_co_pr_read_keys(blk_bs(blk), generation, num_keys, keys);
>> +}
>> +
>> +static void coroutine_fn blk_aio_pr_read_keys_entry(void *opaque)
>> +{
>> + BlkPrInCB *acb = opaque;
>> + BlkPrInCo *prco = &acb->prco;
>> +
>> + prco->ret = blk_aio_pr_do_read_keys(prco->blk, prco->generation,
>> + prco->num_keys, prco->keys);
>> + blk_pr_in_complete(acb);
>> +}
>> +
>> +BlockAIOCB *blk_aio_pr_read_keys(BlockBackend *blk, uint32_t
*generation,
>> + uint32_t num_keys, uint64_t *keys,
>> + BlockCompletionFunc *cb, void *opaque)
>> +{
>> + IO_CODE();
>> + return blk_aio_pr_in(blk, generation, num_keys, NULL, keys,
>> + blk_aio_pr_read_keys_entry, cb, opaque);
>> +}
>> +
>> +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
>> +static int coroutine_fn
>> +blk_aio_pr_do_read_reservation(BlockBackend *blk, uint32_t *generation,
>> + uint64_t *key, BlockPrType *type)
>> +{
>> + IO_CODE();
>> +
>> + blk_wait_while_drained(blk);
>> + GRAPH_RDLOCK_GUARD();
>> +
>> + if (!blk_co_is_available(blk)) {
>> + return -ENOMEDIUM;
>> + }
>> +
>> + return bdrv_co_pr_read_reservation(blk_bs(blk), generation, key,
type);
>> +}
>> +
>> +static void coroutine_fn blk_aio_pr_read_reservation_entry(void
*opaque)
>> +{
>> + BlkPrInCB *acb = opaque;
>> + BlkPrInCo *prco = &acb->prco;
>> +
>> + prco->ret = blk_aio_pr_do_read_reservation(prco->blk,
prco->generation,
>> + prco->keys, prco->type);
>> + blk_pr_in_complete(acb);
>> +}
>> +
>> +BlockAIOCB *blk_aio_pr_read_reservation(BlockBackend *blk, uint32_t
*generation,
>> + uint64_t *key, BlockPrType *type,
>> + BlockCompletionFunc *cb, void *opaque)
>> +{
>> + IO_CODE();
>> + return blk_aio_pr_in(blk, generation, 0, type, key,
>> + blk_aio_pr_read_reservation_entry, cb, opaque);
>> +}
>> +
>> +typedef struct BlkPrOutCo {
>> + BlockBackend *blk;
>> + uint64_t old_key;
>> + uint64_t new_key;
>> + bool ptpl;
>> + BlockPrType type;
>> + bool ignore_key;
>> + bool abort;
>> + int ret;
>> +} BlkPrOutCo;
>> +
>> +typedef struct BlkPrOutCB {
>> + BlockAIOCB common;
>> + BlkPrOutCo prco;
>> + bool has_returned;
>> +} BlkPrOutCB;
>> +
>> +static const AIOCBInfo blk_pr_out_aiocb_info = {
>> + .aiocb_size = sizeof(BlkPrOutCB),
>> +};
>> +
>> +static void blk_pr_out_complete(BlkPrOutCB *acb)
>> +{
>> + if (acb->has_returned) {
>> + acb->common.cb(acb->common.opaque, acb->prco.ret);
>> + blk_dec_in_flight(acb->prco.blk);
>> + qemu_aio_unref(acb);
>> + }
>> +}
>> +
>> +static void blk_pr_out_complete_bh(void *opaque)
>> +{
>> + BlkPrOutCB *acb = opaque;
>> + assert(acb->has_returned);
>> + blk_pr_out_complete(acb);
>> +}
>> +
>> +static BlockAIOCB *blk_aio_pr_out(BlockBackend *blk, uint64_t old_key,
>> + uint64_t new_key, bool ptpl,
>> + BlockPrType type, bool ignore_key,
>> + bool abort, CoroutineEntry co_entry,
>> + BlockCompletionFunc *cb, void *opaque)
>> +{
>> + BlkPrOutCB *acb;
>> + Coroutine *co;
>> +
>> + blk_inc_in_flight(blk);
>> + acb = blk_aio_get(&blk_pr_out_aiocb_info, blk, cb, opaque);
>> + acb->prco = (BlkPrOutCo) {
>> + .blk = blk,
>> + .old_key = old_key,
>> + .new_key = new_key,
>> + .ptpl = ptpl,
>> + .type = type,
>> + .ignore_key = ignore_key,
>> + .abort = abort,
>> + .ret = NOT_DONE,
>> + };
>> + acb->has_returned = false;
>> +
>> + co = qemu_coroutine_create(co_entry, acb);
>> + aio_co_enter(qemu_get_current_aio_context(), co);
>> +
>> + acb->has_returned = true;
>> + if (acb->prco.ret != NOT_DONE) {
>> + replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
>> + blk_pr_out_complete_bh, acb);
>> + }
>> +
>> + return &acb->common;
>> +}
>> +
>> +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
>> +static int coroutine_fn
>> +blk_aio_pr_do_register(BlockBackend *blk, uint64_t old_key,
>> + uint64_t new_key, BlockPrType type,
>> + bool ptpl, bool ignore_key)
>> +{
>> + IO_CODE();
>> +
>> + blk_wait_while_drained(blk);
>> + GRAPH_RDLOCK_GUARD();
>> +
>> + if (!blk_co_is_available(blk)) {
>> + return -ENOMEDIUM;
>> + }
>> +
>> + return bdrv_co_pr_register(blk_bs(blk), old_key, new_key, type,
>> + ptpl, ignore_key);
>> +}
>> +
>> +static void coroutine_fn blk_aio_pr_register_entry(void *opaque)
>> +{
>> + BlkPrOutCB *acb = opaque;
>> + BlkPrOutCo *prco = &acb->prco;
>> +
>> + prco->ret = blk_aio_pr_do_register(prco->blk, prco->old_key,
prco->new_key,
>> + prco->type, prco->ptpl,
>> + prco->ignore_key);
>> + blk_pr_out_complete(acb);
>> +}
>> +
>> +BlockAIOCB *blk_aio_pr_register(BlockBackend *blk, uint64_t old_key,
>> + uint64_t new_key, BlockPrType type,
>> + bool ptpl, bool ignore_key,
>> + BlockCompletionFunc *cb,
>> + void *opaque)
>> +{
>> + IO_CODE();
>> + return blk_aio_pr_out(blk, old_key, new_key, ptpl, type, ignore_key,
false,
>> + blk_aio_pr_register_entry, cb, opaque);
>> +}
>> +
>> +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
>> +static int coroutine_fn
>> +blk_aio_pr_do_reserve(BlockBackend *blk, uint64_t key, BlockPrType
type)
>> +{
>> + IO_CODE();
>> +
>> + blk_wait_while_drained(blk);
>> + GRAPH_RDLOCK_GUARD();
>> +
>> + if (!blk_co_is_available(blk)) {
>> + return -ENOMEDIUM;
>> + }
>> +
>> + return bdrv_co_pr_reserve(blk_bs(blk), key, type);
>> +}
>> +
>> +static void coroutine_fn blk_aio_pr_reserve_entry(void *opaque)
>> +{
>> + BlkPrOutCB *acb = opaque;
>> + BlkPrOutCo *prco = &acb->prco;
>> +
>> + prco->ret = blk_aio_pr_do_reserve(prco->blk, prco->old_key,
>> + prco->type);
>> + blk_pr_out_complete(acb);
>> +}
>> +
>> +
>> +BlockAIOCB *blk_aio_pr_reserve(BlockBackend *blk, uint64_t key,
>> + BlockPrType type,
>> + BlockCompletionFunc *cb,
>> + void *opaque)
>> +{
>> + IO_CODE();
>> + return blk_aio_pr_out(blk, key, 0, false, type, false, false,
>> + blk_aio_pr_reserve_entry, cb, opaque);
>> +}
>> +
>> +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
>> +static int coroutine_fn
>> +blk_aio_pr_do_release(BlockBackend *blk, uint64_t key, BlockPrType
type)
>> +{
>> + IO_CODE();
>> +
>> + blk_wait_while_drained(blk);
>> + GRAPH_RDLOCK_GUARD();
>> +
>> + if (!blk_co_is_available(blk)) {
>> + return -ENOMEDIUM;
>> + }
>> +
>> + return bdrv_co_pr_release(blk_bs(blk), key, type);
>> +}
>> +
>> +static void coroutine_fn blk_aio_pr_release_entry(void *opaque)
>> +{
>> + BlkPrOutCB *acb = opaque;
>> + BlkPrOutCo *prco = &acb->prco;
>> +
>> + prco->ret = blk_aio_pr_do_release(prco->blk, prco->old_key,
prco->type);
>> + blk_pr_out_complete(acb);
>> +}
>> +
>> +
>> +BlockAIOCB *blk_aio_pr_release(BlockBackend *blk, uint64_t key,
>> + BlockPrType type, BlockCompletionFunc *cb,
>> + void *opaque)
>> +{
>> + IO_CODE();
>> + return blk_aio_pr_out(blk, key, 0, false, type, false, false,
>> + blk_aio_pr_release_entry, cb, opaque);
>> +}
>> +
>> +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
>> +static int coroutine_fn
>> +blk_aio_pr_do_clear(BlockBackend *blk, uint64_t key)
>> +{
>> + IO_CODE();
>> +
>> + blk_wait_while_drained(blk);
>> + GRAPH_RDLOCK_GUARD();
>> +
>> + if (!blk_co_is_available(blk)) {
>> + return -ENOMEDIUM;
>> + }
>> +
>> + return bdrv_co_pr_clear(blk_bs(blk), key);
>> +}
>> +
>> +static void coroutine_fn blk_aio_pr_clear_entry(void *opaque)
>> +{
>> + BlkPrOutCB *acb = opaque;
>> + BlkPrOutCo *prco = &acb->prco;
>> +
>> + prco->ret = blk_aio_pr_do_clear(prco->blk, prco->old_key);
>> + blk_pr_out_complete(acb);
>> +}
>> +
>> +
>> +BlockAIOCB *blk_aio_pr_clear(BlockBackend *blk, uint64_t key,
>> + BlockCompletionFunc *cb, void *opaque)
>> +{
>> + IO_CODE();
>> + return blk_aio_pr_out(blk, key, 0, false, 0, false, false,
>> + blk_aio_pr_clear_entry, cb, opaque);
>> +}
>> +
>> +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
>> +static int coroutine_fn
>> +blk_aio_pr_do_preempt(BlockBackend *blk, uint64_t cr_key,
>> + uint64_t pr_key, BlockPrType type, bool abort)
>> +{
>> + IO_CODE();
>> +
>> + blk_wait_while_drained(blk);
>> + GRAPH_RDLOCK_GUARD();
>> +
>> + if (!blk_co_is_available(blk)) {
>> + return -ENOMEDIUM;
>> + }
>> +
>> + return bdrv_co_pr_preempt(blk_bs(blk), cr_key, pr_key, type, abort);
>> +}
>> +
>> +static void coroutine_fn blk_aio_pr_preempt_entry(void *opaque)
>> +{
>> + BlkPrOutCB *acb = opaque;
>> + BlkPrOutCo *prco = &acb->prco;
>> +
>> + prco->ret = blk_aio_pr_do_preempt(prco->blk, prco->old_key,
>> + prco->new_key, prco->type,
>> + prco->abort);
>> + blk_pr_out_complete(acb);
>> +}
>> +
>> +
>> +BlockAIOCB *blk_aio_pr_preempt(BlockBackend *blk, uint64_t cr_key,
>> + uint64_t pr_key, BlockPrType type,
>> + bool abort, BlockCompletionFunc *cb,
>> + void *opaque)
>> +{
>> + IO_CODE();
>> + return blk_aio_pr_out(blk, cr_key, pr_key, false, type, false, abort,
>> + blk_aio_pr_preempt_entry, cb, opaque);
>> +}
>> +
>> /* To be called between exactly one pair of blk_inc/dec_in_flight() */
>> static int coroutine_fn
>> blk_co_do_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes)
>> diff --git a/block/io.c b/block/io.c
>> index 7217cf811b..87a363c94f 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -3220,6 +3220,169 @@ out:
>> return co.ret;
>> }
>>
>> +int coroutine_fn bdrv_co_pr_read_keys(BlockDriverState *bs,
>> + uint32_t *generation, uint32_t num_keys,
>> + uint64_t *keys)
>> +{
>> + BlockDriver *drv = bs->drv;
>> + CoroutineIOCompletion co = {
>> + .coroutine = qemu_coroutine_self(),
>> + };
>> +
>> + IO_CODE();
>> + assert_bdrv_graph_readable();
>> +
>> + bdrv_inc_in_flight(bs);
>> + if (!drv || !drv->bdrv_co_pr_read_keys) {
>> + co.ret = -ENOTSUP;
>> + goto out;
>> + }
>> +
>> + co.ret = drv->bdrv_co_pr_read_keys(bs, generation, num_keys, keys);
>> +out:
>> + bdrv_dec_in_flight(bs);
>> + return co.ret;
>> +}
>> +
>> +int coroutine_fn bdrv_co_pr_read_reservation(BlockDriverState *bs,
>> + uint32_t *generation, uint64_t *key, BlockPrType *type)
>> +{
>> + BlockDriver *drv = bs->drv;
>> + CoroutineIOCompletion co = {
>> + .coroutine = qemu_coroutine_self(),
>> + };
>> +
>> + IO_CODE();
>> + assert_bdrv_graph_readable();
>> +
>> + bdrv_inc_in_flight(bs);
>> + if (!drv || !drv->bdrv_co_pr_read_reservation) {
>> + co.ret = -ENOTSUP;
>> + goto out;
>> + }
>> +
>> + co.ret = drv->bdrv_co_pr_read_reservation(bs, generation, key, type);
>> +out:
>> + bdrv_dec_in_flight(bs);
>> + return co.ret;
>> +}
>> +
>> +int coroutine_fn bdrv_co_pr_register(BlockDriverState *bs, uint64_t
old_key,
>> + uint64_t new_key, BlockPrType type, bool ptpl,
>> + bool ignore_key)
>> +{
>> + BlockDriver *drv = bs->drv;
>> + CoroutineIOCompletion co = {
>> + .coroutine = qemu_coroutine_self(),
>> + };
>> +
>> + IO_CODE();
>> + assert_bdrv_graph_readable();
>> +
>> + bdrv_inc_in_flight(bs);
>> + if (!drv || !drv->bdrv_co_pr_register) {
>> + co.ret = -ENOTSUP;
>> + goto out;
>> + }
>> +
>> + co.ret = drv->bdrv_co_pr_register(bs, old_key, new_key, type,
>> + ptpl, ignore_key);
>> +out:
>> + bdrv_dec_in_flight(bs);
>> + return co.ret;
>> +}
>> +
>> +int coroutine_fn bdrv_co_pr_reserve(BlockDriverState *bs, uint64_t key,
>> + BlockPrType type)
>> +{
>> + BlockDriver *drv = bs->drv;
>> + CoroutineIOCompletion co = {
>> + .coroutine = qemu_coroutine_self(),
>> + };
>> +
>> + IO_CODE();
>> + assert_bdrv_graph_readable();
>> +
>> + bdrv_inc_in_flight(bs);
>> + if (!drv || !drv->bdrv_co_pr_reserve) {
>> + co.ret = -ENOTSUP;
>> + goto out;
>> + }
>> +
>> + co.ret = drv->bdrv_co_pr_reserve(bs, key, type);
>> +out:
>> + bdrv_dec_in_flight(bs);
>> + return co.ret;
>> +}
>> +
>> +int coroutine_fn bdrv_co_pr_release(BlockDriverState *bs, uint64_t key,
>> + BlockPrType type)
>> +{
>> + BlockDriver *drv = bs->drv;
>> + CoroutineIOCompletion co = {
>> + .coroutine = qemu_coroutine_self(),
>> + };
>> +
>> + IO_CODE();
>> + assert_bdrv_graph_readable();
>> +
>> + bdrv_inc_in_flight(bs);
>> + if (!drv || !drv->bdrv_co_pr_release) {
>> + co.ret = -ENOTSUP;
>> + goto out;
>> + }
>> +
>> + co.ret = drv->bdrv_co_pr_release(bs, key, type);
>> +out:
>> + bdrv_dec_in_flight(bs);
>> + return co.ret;
>> +}
>> +
>> +int coroutine_fn bdrv_co_pr_clear(BlockDriverState *bs, uint64_t key)
>> +{
>> + BlockDriver *drv = bs->drv;
>> + CoroutineIOCompletion co = {
>> + .coroutine = qemu_coroutine_self(),
>> + };
>> +
>> + IO_CODE();
>> + assert_bdrv_graph_readable();
>> +
>> + bdrv_inc_in_flight(bs);
>> + if (!drv || !drv->bdrv_co_pr_clear) {
>> + co.ret = -ENOTSUP;
>> + goto out;
>> + }
>> +
>> + co.ret = drv->bdrv_co_pr_clear(bs, key);
>> +out:
>> + bdrv_dec_in_flight(bs);
>> + return co.ret;
>> +}
>> +
>> +int coroutine_fn bdrv_co_pr_preempt(BlockDriverState *bs, uint64_t
cr_key,
>> + uint64_t pr_key, BlockPrType type, bool abort)
>> +{
>> + BlockDriver *drv = bs->drv;
>> + CoroutineIOCompletion co = {
>> + .coroutine = qemu_coroutine_self(),
>> + };
>> +
>> + IO_CODE();
>> + assert_bdrv_graph_readable();
>> +
>> + bdrv_inc_in_flight(bs);
>> + if (!drv || !drv->bdrv_co_pr_preempt) {
>> + co.ret = -ENOTSUP;
>> + goto out;
>> + }
>> +
>> + co.ret = drv->bdrv_co_pr_preempt(bs, cr_key, pr_key, type, abort);
>> +out:
>> + bdrv_dec_in_flight(bs);
>> + return co.ret;
>> +}
>> +
>> int coroutine_fn bdrv_co_zone_report(BlockDriverState *bs, int64_t
offset,
>> unsigned int *nr_zones,
>> BlockZoneDescriptor *zones)
>> diff --git a/include/block/block-common.h b/include/block/block-common.h
>> index a846023a09..7ca4e2328f 100644
>> --- a/include/block/block-common.h
>> +++ b/include/block/block-common.h
>> @@ -524,6 +524,46 @@ typedef enum {
>> BDRV_FIX_ERRORS = 2,
>> } BdrvCheckMode;
>>
>> +/**
>> + * According SCSI protocol(chapter 5.9 of SCSI Primary Commands - 4)
>> + * and NVMe protocol(chapter 7.2 of NVMe Base Specification 2.0),
>> + * the persistent reservation types and persistent capabilities of
>> + * the public layer block are abstracted.
>> + */
>> +typedef enum {
>> + BLK_PR_WRITE_EXCLUSIVE = 0x1,
>> + BLK_PR_EXCLUSIVE_ACCESS = 0x2,
>> + BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY = 0x3,
>> + BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY = 0x4,
>> + BLK_PR_WRITE_EXCLUSIVE_ALL_REGS = 0x5,
>> + BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS = 0x6,
>> +} BlockPrType;
>> +
>> +typedef enum BLKPrCap {
>> + /* Persist Through Power Loss */
>> + BLK_PR_CAP_PTPL = 1 << 0,
>> + /* Write Exclusive reservation type */
>> + BLK_PR_CAP_WR_EX = 1 << 1,
>> + /* Exclusive Access reservation type */
>> + BLK_PR_CAP_EX_AC = 1 << 2,
>> + /* Write Exclusive Registrants Only reservation type */
>> + BLK_PR_CAP_WR_EX_RO = 1 << 3,
>> + /* Exclusive Access Registrants Only reservation type */
>> + BLK_PR_CAP_EX_AC_RO = 1 << 4,
>> + /* Write Exclusive All Registrants reservation type */
>> + BLK_PR_CAP_WR_EX_AR = 1 << 5,
>> + /* Exclusive Access All Registrants reservation type */
>> + BLK_PR_CAP_EX_AC_AR = 1 << 6,
>> +
>> + BLK_PR_CAP_ALL = (BLK_PR_CAP_PTPL |
>> + BLK_PR_CAP_WR_EX |
>> + BLK_PR_CAP_EX_AC |
>> + BLK_PR_CAP_WR_EX_RO |
>> + BLK_PR_CAP_EX_AC_RO |
>> + BLK_PR_CAP_WR_EX_AR |
>> + BLK_PR_CAP_EX_AC_AR),
>> +} BLKPrCap;
>> +
>> typedef struct BlockSizes {
>> uint32_t phys;
>> uint32_t log;
>> diff --git a/include/block/block-io.h b/include/block/block-io.h
>> index b49e0537dd..908361862b 100644
>> --- a/include/block/block-io.h
>> +++ b/include/block/block-io.h
>> @@ -106,6 +106,26 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb);
>> int coroutine_fn GRAPH_RDLOCK
>> bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf);
>>
>> +int coroutine_fn GRAPH_RDLOCK
>> +bdrv_co_pr_read_keys(BlockDriverState *bs, uint32_t *generation,
>> + uint32_t num_keys, uint64_t *keys);
>> +int coroutine_fn GRAPH_RDLOCK
>> +bdrv_co_pr_read_reservation(BlockDriverState *bs, uint32_t *generation,
>> + uint64_t *key, BlockPrType *type);
>> +int coroutine_fn GRAPH_RDLOCK
>> +bdrv_co_pr_register(BlockDriverState *bs, uint64_t old_key,
>> + uint64_t new_key, BlockPrType type,
>> + bool ptpl, bool ignore_key);
>> +int coroutine_fn GRAPH_RDLOCK
>> +bdrv_co_pr_reserve(BlockDriverState *bs, uint64_t key, BlockPrType
type);
>> +int coroutine_fn GRAPH_RDLOCK
>> +bdrv_co_pr_release(BlockDriverState *bs, uint64_t key, BlockPrType
type);
>> +int coroutine_fn GRAPH_RDLOCK
>> +bdrv_co_pr_clear(BlockDriverState *bs, uint64_t key);
>> +int coroutine_fn GRAPH_RDLOCK
>> +bdrv_co_pr_preempt(BlockDriverState *bs, uint64_t cr_key, uint64_t
pr_key,
>> + BlockPrType type, bool abort);
>> +
>> /* Ensure contents are flushed to disk. */
>> int coroutine_fn GRAPH_RDLOCK bdrv_co_flush(BlockDriverState *bs);
>>
>> diff --git a/include/block/block_int-common.h
b/include/block/block_int-common.h
>> index 761276127e..6e628069e9 100644
>> --- a/include/block/block_int-common.h
>> +++ b/include/block/block_int-common.h
>> @@ -766,6 +766,87 @@ struct BlockDriver {
>> int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_ioctl)(
>> BlockDriverState *bs, unsigned long int req, void *buf);
>>
>> + /*
>> + * Persistent reservation series api.
>> + * Please refer to chapter 5.9 of SCSI Primary Commands - 4 or
>> + * chapter 7 of NVMe Base Specification 2.0.
>> + *
>> + * The block layer driver should implement all the following APIs
>> + * or none at all, including: bdrv_co_pr_read_keys,
>> + * bdrv_co_pr_read_reservation, bdrv_co_pr_register,
>> + * bdrv_co_pr_reserve, bdrv_co_pr_release,
>> + * bdrv_co_pr_clear and bdrv_co_pr_preempt.
>> + *
>> + * Read the registered keys and return them in the @keys.
>> + * @generation: The generation of the reservation key.
>> + * @num_keys: The maximum number of keys that can be transmitted.
>> + * @keys: Registered keys array.
>> + *
>> + * On success, store generation in @generation and store keys @keys
>> + * and return the number of @keys.
>> + * On failure return -errno.
>> + */
>> + int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_read_keys)(
>> + BlockDriverState *bs, uint32_t *generation,
>> + uint32_t num_keys, uint64_t *keys);
>> + /*
>> + * Read the reservation key and store it in the @key.
>> + * @generation: The generation of the reservation key.
>> + * @key: The reservation key.
>> + * @type: Type of the reservation key.
>> + *
>> + * On success, store generation in @generation, store the
>> + * reservation key in @key and return the number of @key
>> + * which used to determine whether the reservation key exists.
>> + * On failure return -errno.
>> + */
>> + int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_read_reservation)(
>> + BlockDriverState *bs, uint32_t *generation,
>> + uint64_t *key, BlockPrType *type);
>> + /*
>> + * Register, unregister, or replace a reservation key.
>> + * @old_key: The current reservation key associated with the host.
>> + * @new_key: The new reservation Key.
>> + * @type: Type of the reservation key.
>> + * @ignore_key: Ignore or not @old_key.
>> + * @ptpl: Whether to support Persist Through Power Loss(PTPL).
>> + */
>> + int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_register)(
>> + BlockDriverState *bs, uint64_t old_key,
>> + uint64_t new_key, BlockPrType type,
>> + bool ptpl, bool ignore_key);
>> + /*
>> + * Acquire a reservation on a host.
>> + * @key: The current reservation key associated with the host.
>> + * @type: Type of the reservation key.
>> + */
>> + int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_reserve)(
>> + BlockDriverState *bs, uint64_t key, BlockPrType type);
>> + /*
>> + * Release a reservation on a host.
>> + * @key: The current reservation key associated with the host.
>> + * @type: Type of the reservation key.
>> + */
>> + int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_release)(
>> + BlockDriverState *bs, uint64_t key, BlockPrType type);
>> + /**
>> + * Clear reservations on a host.
>> + * @key: The current reservation key associated with the host.
>> + */
>> + int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_clear)(
>> + BlockDriverState *bs, uint64_t key);
>> + /*
>> + * Preempt a reservation held on a host.
>> + * @cr_key: The current reservation key associated with the host.
>> + * @pr_key: The preempt reservation Key which to be
>> + * unregistered from the namespace.
>> + * @type: Type of the reservation key.
>> + * @abort: Whether to abort a reservation held on a host.
>> + */
>> + int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_preempt)(
>> + BlockDriverState *bs, uint64_t cr_key,
>> + uint64_t pr_key, BlockPrType type, bool abort);
>> +
>> /*
>> * Returns 0 for completed check, -errno for internal errors.
>> * The check results are stored in result.
>> @@ -899,6 +980,9 @@ typedef struct BlockLimits {
>> uint32_t max_active_zones;
>>
>> uint32_t write_granularity;
>> +
>> + /* Persistent reservation capacities. */
>> + uint8_t pr_cap;
>> } BlockLimits;
>>
>> typedef struct BdrvOpBlocker BdrvOpBlocker;
>> diff --git a/include/sysemu/block-backend-io.h
b/include/sysemu/block-backend-io.h
>> index d174275a5c..b3d49a3c6f 100644
>> --- a/include/sysemu/block-backend-io.h
>> +++ b/include/sysemu/block-backend-io.h
>> @@ -62,6 +62,30 @@ void blk_aio_cancel_async(BlockAIOCB *acb);
>> BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void
*buf,
>> BlockCompletionFunc *cb, void *opaque);
>>
>> +BlockAIOCB *blk_aio_pr_read_keys(BlockBackend *blk, uint32_t
*generation,
>> + uint32_t num_keys, uint64_t *keys,
>> + BlockCompletionFunc *cb, void *opaque);
>> +BlockAIOCB *blk_aio_pr_read_reservation(BlockBackend *blk, uint32_t
*generation,
>> + uint64_t *key, BlockPrType *type,
>> + BlockCompletionFunc *cb, void *opaque);
>> +BlockAIOCB *blk_aio_pr_register(BlockBackend *blk, uint64_t old_key,
>> + uint64_t new_key, BlockPrType type,
>> + bool ptpl, bool ignore_key,
>> + BlockCompletionFunc *cb,
>> + void *opaque);
>> +BlockAIOCB *blk_aio_pr_reserve(BlockBackend *blk, uint64_t key,
>> + BlockPrType type,
>> + BlockCompletionFunc *cb,
>> + void *opaque);
>> +BlockAIOCB *blk_aio_pr_release(BlockBackend *blk, uint64_t key,
>> + BlockPrType type, BlockCompletionFunc *cb,
>> + void *opaque);
>> +BlockAIOCB *blk_aio_pr_clear(BlockBackend *blk, uint64_t key,
>> + BlockCompletionFunc *cb, void *opaque);
>> +BlockAIOCB *blk_aio_pr_preempt(BlockBackend *blk, uint64_t cr_key,
>> + uint64_t pr_key, BlockPrType type, bool abort,
>> + BlockCompletionFunc *cb, void *opaque);
>> +
>> void blk_inc_in_flight(BlockBackend *blk);
>> void blk_dec_in_flight(BlockBackend *blk);
>>
>> --
>> 2.20.1
>>

--000000000000af0140061a944049
Content-Type: text/html; charset="UTF-8"

<p>Hi,
<br>
<br>Thanks for your advices! I will add it.
<br>
<br>On 2024/6/11 01:26, Stefan Hajnoczi wrote:
<br>&gt; On Thu, Jun 06, 2024 at 08:24:35PM +0800, Changqi Lu wrote:
<br>&gt;&gt; Add persistent reservation in/out operations
<br>&gt;&gt; at the block level. The following operations
<br>&gt;&gt; are included:
<br>&gt;&gt;
<br>&gt;&gt; - read_keys:        retrieves the list of registered keys.
<br>&gt;&gt; - read_reservation: retrieves the current reservation status.
<br>&gt;&gt; - register:         registers a new reservation key.
<br>&gt;&gt; - reserve:          initiates a reservation for a specific key.
<br>&gt;&gt; - release:          releases a reservation for a specific key.
<br>&gt;&gt; - clear:            clears all existing reservations.
<br>&gt;&gt; - preempt:          preempts a reservation held by another key.
<br>&gt;&gt;
<br>&gt;&gt; Signed-off-by: Changqi Lu 
<br>&gt;&gt; Signed-off-by: zhenwei pi 
<br>&gt;&gt; ---
<br>&gt;&gt;  block/block-backend.c             | 397 ++++++++++++++++++++++++++++++
<br>&gt;&gt;  block/io.c                        | 163 ++++++++++++
<br>&gt;&gt;  include/block/block-common.h      |  40 +++
<br>&gt;&gt;  include/block/block-io.h          |  20 ++
<br>&gt;&gt;  include/block/block_int-common.h  |  84 +++++++
<br>&gt;&gt;  include/sysemu/block-backend-io.h |  24 ++
<br>&gt;&gt;  6 files changed, 728 insertions(+)
<br>&gt;&gt;
<br>&gt;&gt; diff --git a/block/block-backend.c b/block/block-backend.c
<br>&gt;&gt; index db6f9b92a3..6707d94df7 100644
<br>&gt;&gt; --- a/block/block-backend.c
<br>&gt;&gt; +++ b/block/block-backend.c
<br>&gt;&gt; @@ -1770,6 +1770,403 @@ BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
<br>&gt;&gt;      return blk_aio_prwv(blk, req, 0, buf, blk_aio_ioctl_entry, 0, cb, opaque);
<br>&gt;&gt;  }
<br>&gt;&gt;  
<br>&gt;&gt; +typedef struct BlkPrInCo {
<br>&gt;&gt; +    BlockBackend *blk;
<br>&gt;&gt; +    uint32_t *generation;
<br>&gt;&gt; +    uint32_t num_keys;
<br>&gt;&gt; +    BlockPrType *type;
<br>&gt;&gt; +    uint64_t *keys;
<br>&gt;&gt; +    int ret;
<br>&gt;&gt; +} BlkPrInCo;
<br>&gt;&gt; +
<br>&gt;&gt; +typedef struct BlkPrInCB {
<br>&gt;&gt; +    BlockAIOCB common;
<br>&gt;&gt; +    BlkPrInCo prco;
<br>&gt;&gt; +    bool has_returned;
<br>&gt;&gt; +} BlkPrInCB;
<br>&gt;&gt; +
<br>&gt;&gt; +static const AIOCBInfo blk_pr_in_aiocb_info = {
<br>&gt;&gt; +    .aiocb_size         = sizeof(BlkPrInCB),
<br>&gt;&gt; +};
<br>&gt;&gt; +
<br>&gt;&gt; +static void blk_pr_in_complete(BlkPrInCB *acb)
<br>&gt;&gt; +{
<br>&gt;&gt; +    if (acb-&gt;has_returned) {
<br>&gt;&gt; +        acb-&gt;common.cb(acb-&gt;common.opaque, acb-&gt;prco.ret);
<br>&gt;&gt; +        blk_dec_in_flight(acb-&gt;prco.blk);
<br>&gt; 
<br>&gt; Did you receive my replies to v1 of this patch series?
<br>&gt; 
<br>&gt; Please take a look at them and respond:
<br>&gt; <a href="https://lore.kernel.org/qemu-devel/20240508093629.441057-1-luchangqi.123@bytedance.com/">https://lore.kernel.org/qemu-devel/20240508093629.441057-1-luchangqi.123@bytedance.com/</a>
<br>&gt; 
<br>&gt; Thanks,
<br>&gt; Stefan
<br>&gt; 
<br>&gt;&gt; +        qemu_aio_unref(acb);
<br>&gt;&gt; +    }
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +static void blk_pr_in_complete_bh(void *opaque)
<br>&gt;&gt; +{
<br>&gt;&gt; +    BlkPrInCB *acb = opaque;
<br>&gt;&gt; +    assert(acb-&gt;has_returned);
<br>&gt;&gt; +    blk_pr_in_complete(acb);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +static BlockAIOCB *blk_aio_pr_in(BlockBackend *blk, uint32_t *generation,
<br>&gt;&gt; +                                 uint32_t num_keys, BlockPrType *type,
<br>&gt;&gt; +                                 uint64_t *keys, CoroutineEntry co_entry,
<br>&gt;&gt; +                                 BlockCompletionFunc *cb, void *opaque)
<br>&gt;&gt; +{
<br>&gt;&gt; +    BlkPrInCB *acb;
<br>&gt;&gt; +    Coroutine *co;
<br>&gt;&gt; +
<br>&gt;&gt; +    blk_inc_in_flight(blk);
<br>&gt;&gt; +    acb = blk_aio_get(&amp;blk_pr_in_aiocb_info, blk, cb, opaque);
<br>&gt;&gt; +    acb-&gt;prco = (BlkPrInCo) {
<br>&gt;&gt; +        .blk        = blk,
<br>&gt;&gt; +        .generation = generation,
<br>&gt;&gt; +        .num_keys   = num_keys,
<br>&gt;&gt; +        .type       = type,
<br>&gt;&gt; +        .ret        = NOT_DONE,
<br>&gt;&gt; +        .keys       = keys,
<br>&gt;&gt; +    };
<br>&gt;&gt; +    acb-&gt;has_returned = false;
<br>&gt;&gt; +
<br>&gt;&gt; +    co = qemu_coroutine_create(co_entry, acb);
<br>&gt;&gt; +    aio_co_enter(qemu_get_current_aio_context(), co);
<br>&gt;&gt; +
<br>&gt;&gt; +    acb-&gt;has_returned = true;
<br>&gt;&gt; +    if (acb-&gt;prco.ret != NOT_DONE) {
<br>&gt;&gt; +        replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
<br>&gt;&gt; +                                         blk_pr_in_complete_bh, acb);
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    return &amp;acb-&gt;common;
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
<br>&gt;&gt; +static int coroutine_fn
<br>&gt;&gt; +blk_aio_pr_do_read_keys(BlockBackend *blk, uint32_t *generation,
<br>&gt;&gt; +                        uint32_t num_keys, uint64_t *keys)
<br>&gt;&gt; +{
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +
<br>&gt;&gt; +    blk_wait_while_drained(blk);
<br>&gt;&gt; +    GRAPH_RDLOCK_GUARD();
<br>&gt;&gt; +
<br>&gt;&gt; +    if (!blk_co_is_available(blk)) {
<br>&gt;&gt; +        return -ENOMEDIUM;
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    return bdrv_co_pr_read_keys(blk_bs(blk), generation, num_keys, keys);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +static void coroutine_fn blk_aio_pr_read_keys_entry(void *opaque)
<br>&gt;&gt; +{
<br>&gt;&gt; +    BlkPrInCB *acb = opaque;
<br>&gt;&gt; +    BlkPrInCo *prco = &amp;acb-&gt;prco;
<br>&gt;&gt; +
<br>&gt;&gt; +    prco-&gt;ret = blk_aio_pr_do_read_keys(prco-&gt;blk, prco-&gt;generation,
<br>&gt;&gt; +                                        prco-&gt;num_keys, prco-&gt;keys);
<br>&gt;&gt; +    blk_pr_in_complete(acb);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +BlockAIOCB *blk_aio_pr_read_keys(BlockBackend *blk, uint32_t *generation,
<br>&gt;&gt; +                                 uint32_t num_keys, uint64_t *keys,
<br>&gt;&gt; +                                 BlockCompletionFunc *cb, void *opaque)
<br>&gt;&gt; +{
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +    return blk_aio_pr_in(blk, generation, num_keys, NULL, keys,
<br>&gt;&gt; +                         blk_aio_pr_read_keys_entry, cb, opaque);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
<br>&gt;&gt; +static int coroutine_fn
<br>&gt;&gt; +blk_aio_pr_do_read_reservation(BlockBackend *blk, uint32_t *generation,
<br>&gt;&gt; +                               uint64_t *key, BlockPrType *type)
<br>&gt;&gt; +{
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +
<br>&gt;&gt; +    blk_wait_while_drained(blk);
<br>&gt;&gt; +    GRAPH_RDLOCK_GUARD();
<br>&gt;&gt; +
<br>&gt;&gt; +    if (!blk_co_is_available(blk)) {
<br>&gt;&gt; +        return -ENOMEDIUM;
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    return bdrv_co_pr_read_reservation(blk_bs(blk), generation, key, type);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +static void coroutine_fn blk_aio_pr_read_reservation_entry(void *opaque)
<br>&gt;&gt; +{
<br>&gt;&gt; +    BlkPrInCB *acb = opaque;
<br>&gt;&gt; +    BlkPrInCo *prco = &amp;acb-&gt;prco;
<br>&gt;&gt; +
<br>&gt;&gt; +    prco-&gt;ret = blk_aio_pr_do_read_reservation(prco-&gt;blk, prco-&gt;generation,
<br>&gt;&gt; +                                               prco-&gt;keys, prco-&gt;type);
<br>&gt;&gt; +    blk_pr_in_complete(acb);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +BlockAIOCB *blk_aio_pr_read_reservation(BlockBackend *blk, uint32_t *generation,
<br>&gt;&gt; +                                        uint64_t *key, BlockPrType *type,
<br>&gt;&gt; +                                        BlockCompletionFunc *cb, void *opaque)
<br>&gt;&gt; +{
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +    return blk_aio_pr_in(blk, generation, 0, type, key,
<br>&gt;&gt; +                         blk_aio_pr_read_reservation_entry, cb, opaque);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +typedef struct BlkPrOutCo {
<br>&gt;&gt; +    BlockBackend *blk;
<br>&gt;&gt; +    uint64_t old_key;
<br>&gt;&gt; +    uint64_t new_key;
<br>&gt;&gt; +    bool ptpl;
<br>&gt;&gt; +    BlockPrType type;
<br>&gt;&gt; +    bool ignore_key;
<br>&gt;&gt; +    bool abort;
<br>&gt;&gt; +    int ret;
<br>&gt;&gt; +} BlkPrOutCo;
<br>&gt;&gt; +
<br>&gt;&gt; +typedef struct BlkPrOutCB {
<br>&gt;&gt; +    BlockAIOCB common;
<br>&gt;&gt; +    BlkPrOutCo prco;
<br>&gt;&gt; +    bool has_returned;
<br>&gt;&gt; +} BlkPrOutCB;
<br>&gt;&gt; +
<br>&gt;&gt; +static const AIOCBInfo blk_pr_out_aiocb_info = {
<br>&gt;&gt; +    .aiocb_size         = sizeof(BlkPrOutCB),
<br>&gt;&gt; +};
<br>&gt;&gt; +
<br>&gt;&gt; +static void blk_pr_out_complete(BlkPrOutCB *acb)
<br>&gt;&gt; +{
<br>&gt;&gt; +    if (acb-&gt;has_returned) {
<br>&gt;&gt; +        acb-&gt;common.cb(acb-&gt;common.opaque, acb-&gt;prco.ret);
<br>&gt;&gt; +        blk_dec_in_flight(acb-&gt;prco.blk);
<br>&gt;&gt; +        qemu_aio_unref(acb);
<br>&gt;&gt; +    }
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +static void blk_pr_out_complete_bh(void *opaque)
<br>&gt;&gt; +{
<br>&gt;&gt; +    BlkPrOutCB *acb = opaque;
<br>&gt;&gt; +    assert(acb-&gt;has_returned);
<br>&gt;&gt; +    blk_pr_out_complete(acb);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +static BlockAIOCB *blk_aio_pr_out(BlockBackend *blk, uint64_t old_key,
<br>&gt;&gt; +                                  uint64_t new_key, bool ptpl,
<br>&gt;&gt; +                                  BlockPrType type, bool ignore_key,
<br>&gt;&gt; +                                  bool abort, CoroutineEntry co_entry,
<br>&gt;&gt; +                                  BlockCompletionFunc *cb, void *opaque)
<br>&gt;&gt; +{
<br>&gt;&gt; +    BlkPrOutCB *acb;
<br>&gt;&gt; +    Coroutine *co;
<br>&gt;&gt; +
<br>&gt;&gt; +    blk_inc_in_flight(blk);
<br>&gt;&gt; +    acb = blk_aio_get(&amp;blk_pr_out_aiocb_info, blk, cb, opaque);
<br>&gt;&gt; +    acb-&gt;prco = (BlkPrOutCo) {
<br>&gt;&gt; +        .blk        = blk,
<br>&gt;&gt; +        .old_key    = old_key,
<br>&gt;&gt; +        .new_key    = new_key,
<br>&gt;&gt; +        .ptpl       = ptpl,
<br>&gt;&gt; +        .type       = type,
<br>&gt;&gt; +        .ignore_key = ignore_key,
<br>&gt;&gt; +        .abort      = abort,
<br>&gt;&gt; +        .ret        = NOT_DONE,
<br>&gt;&gt; +    };
<br>&gt;&gt; +    acb-&gt;has_returned = false;
<br>&gt;&gt; +
<br>&gt;&gt; +    co = qemu_coroutine_create(co_entry, acb);
<br>&gt;&gt; +    aio_co_enter(qemu_get_current_aio_context(), co);
<br>&gt;&gt; +
<br>&gt;&gt; +    acb-&gt;has_returned = true;
<br>&gt;&gt; +    if (acb-&gt;prco.ret != NOT_DONE) {
<br>&gt;&gt; +        replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
<br>&gt;&gt; +                                         blk_pr_out_complete_bh, acb);
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    return &amp;acb-&gt;common;
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
<br>&gt;&gt; +static int coroutine_fn
<br>&gt;&gt; +blk_aio_pr_do_register(BlockBackend *blk, uint64_t old_key,
<br>&gt;&gt; +                       uint64_t new_key, BlockPrType type,
<br>&gt;&gt; +                       bool ptpl, bool ignore_key)
<br>&gt;&gt; +{
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +
<br>&gt;&gt; +    blk_wait_while_drained(blk);
<br>&gt;&gt; +    GRAPH_RDLOCK_GUARD();
<br>&gt;&gt; +
<br>&gt;&gt; +    if (!blk_co_is_available(blk)) {
<br>&gt;&gt; +        return -ENOMEDIUM;
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    return bdrv_co_pr_register(blk_bs(blk), old_key, new_key, type,
<br>&gt;&gt; +                               ptpl, ignore_key);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +static void coroutine_fn blk_aio_pr_register_entry(void *opaque)
<br>&gt;&gt; +{
<br>&gt;&gt; +    BlkPrOutCB *acb = opaque;
<br>&gt;&gt; +    BlkPrOutCo *prco = &amp;acb-&gt;prco;
<br>&gt;&gt; +
<br>&gt;&gt; +    prco-&gt;ret = blk_aio_pr_do_register(prco-&gt;blk, prco-&gt;old_key, prco-&gt;new_key,
<br>&gt;&gt; +                                       prco-&gt;type, prco-&gt;ptpl,
<br>&gt;&gt; +                                       prco-&gt;ignore_key);
<br>&gt;&gt; +    blk_pr_out_complete(acb);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +BlockAIOCB *blk_aio_pr_register(BlockBackend *blk, uint64_t old_key,
<br>&gt;&gt; +                                uint64_t new_key, BlockPrType type,
<br>&gt;&gt; +                                bool ptpl, bool ignore_key,
<br>&gt;&gt; +                                BlockCompletionFunc *cb,
<br>&gt;&gt; +                                void *opaque)
<br>&gt;&gt; +{
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +    return blk_aio_pr_out(blk, old_key, new_key, ptpl, type, ignore_key, false,
<br>&gt;&gt; +                          blk_aio_pr_register_entry, cb, opaque);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
<br>&gt;&gt; +static int coroutine_fn
<br>&gt;&gt; +blk_aio_pr_do_reserve(BlockBackend *blk, uint64_t key, BlockPrType type)
<br>&gt;&gt; +{
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +
<br>&gt;&gt; +    blk_wait_while_drained(blk);
<br>&gt;&gt; +    GRAPH_RDLOCK_GUARD();
<br>&gt;&gt; +
<br>&gt;&gt; +    if (!blk_co_is_available(blk)) {
<br>&gt;&gt; +        return -ENOMEDIUM;
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    return bdrv_co_pr_reserve(blk_bs(blk), key, type);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +static void coroutine_fn blk_aio_pr_reserve_entry(void *opaque)
<br>&gt;&gt; +{
<br>&gt;&gt; +    BlkPrOutCB *acb = opaque;
<br>&gt;&gt; +    BlkPrOutCo *prco = &amp;acb-&gt;prco;
<br>&gt;&gt; +
<br>&gt;&gt; +    prco-&gt;ret = blk_aio_pr_do_reserve(prco-&gt;blk, prco-&gt;old_key,
<br>&gt;&gt; +                                      prco-&gt;type);
<br>&gt;&gt; +    blk_pr_out_complete(acb);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +
<br>&gt;&gt; +BlockAIOCB *blk_aio_pr_reserve(BlockBackend *blk,  uint64_t key,
<br>&gt;&gt; +                               BlockPrType type,
<br>&gt;&gt; +                               BlockCompletionFunc *cb,
<br>&gt;&gt; +                               void *opaque)
<br>&gt;&gt; +{
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +    return blk_aio_pr_out(blk, key, 0, false, type, false, false,
<br>&gt;&gt; +                          blk_aio_pr_reserve_entry, cb, opaque);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
<br>&gt;&gt; +static int coroutine_fn
<br>&gt;&gt; +blk_aio_pr_do_release(BlockBackend *blk, uint64_t key, BlockPrType type)
<br>&gt;&gt; +{
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +
<br>&gt;&gt; +    blk_wait_while_drained(blk);
<br>&gt;&gt; +    GRAPH_RDLOCK_GUARD();
<br>&gt;&gt; +
<br>&gt;&gt; +    if (!blk_co_is_available(blk)) {
<br>&gt;&gt; +        return -ENOMEDIUM;
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    return bdrv_co_pr_release(blk_bs(blk), key, type);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +static void coroutine_fn blk_aio_pr_release_entry(void *opaque)
<br>&gt;&gt; +{
<br>&gt;&gt; +    BlkPrOutCB *acb = opaque;
<br>&gt;&gt; +    BlkPrOutCo *prco = &amp;acb-&gt;prco;
<br>&gt;&gt; +
<br>&gt;&gt; +    prco-&gt;ret = blk_aio_pr_do_release(prco-&gt;blk, prco-&gt;old_key, prco-&gt;type);
<br>&gt;&gt; +    blk_pr_out_complete(acb);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +
<br>&gt;&gt; +BlockAIOCB *blk_aio_pr_release(BlockBackend *blk, uint64_t key,
<br>&gt;&gt; +                               BlockPrType type, BlockCompletionFunc *cb,
<br>&gt;&gt; +                               void *opaque)
<br>&gt;&gt; +{
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +    return blk_aio_pr_out(blk, key, 0, false, type, false, false,
<br>&gt;&gt; +                          blk_aio_pr_release_entry, cb, opaque);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
<br>&gt;&gt; +static int coroutine_fn
<br>&gt;&gt; +blk_aio_pr_do_clear(BlockBackend *blk, uint64_t key)
<br>&gt;&gt; +{
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +
<br>&gt;&gt; +    blk_wait_while_drained(blk);
<br>&gt;&gt; +    GRAPH_RDLOCK_GUARD();
<br>&gt;&gt; +
<br>&gt;&gt; +    if (!blk_co_is_available(blk)) {
<br>&gt;&gt; +        return -ENOMEDIUM;
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    return bdrv_co_pr_clear(blk_bs(blk), key);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +static void coroutine_fn blk_aio_pr_clear_entry(void *opaque)
<br>&gt;&gt; +{
<br>&gt;&gt; +    BlkPrOutCB *acb = opaque;
<br>&gt;&gt; +    BlkPrOutCo *prco = &amp;acb-&gt;prco;
<br>&gt;&gt; +
<br>&gt;&gt; +    prco-&gt;ret = blk_aio_pr_do_clear(prco-&gt;blk, prco-&gt;old_key);
<br>&gt;&gt; +    blk_pr_out_complete(acb);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +
<br>&gt;&gt; +BlockAIOCB *blk_aio_pr_clear(BlockBackend *blk, uint64_t key,
<br>&gt;&gt; +                             BlockCompletionFunc *cb, void *opaque)
<br>&gt;&gt; +{
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +    return blk_aio_pr_out(blk, key, 0, false, 0, false, false,
<br>&gt;&gt; +                          blk_aio_pr_clear_entry, cb, opaque);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
<br>&gt;&gt; +static int coroutine_fn
<br>&gt;&gt; +blk_aio_pr_do_preempt(BlockBackend *blk, uint64_t cr_key,
<br>&gt;&gt; +                      uint64_t pr_key, BlockPrType type, bool abort)
<br>&gt;&gt; +{
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +
<br>&gt;&gt; +    blk_wait_while_drained(blk);
<br>&gt;&gt; +    GRAPH_RDLOCK_GUARD();
<br>&gt;&gt; +
<br>&gt;&gt; +    if (!blk_co_is_available(blk)) {
<br>&gt;&gt; +        return -ENOMEDIUM;
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    return bdrv_co_pr_preempt(blk_bs(blk), cr_key, pr_key, type, abort);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +static void coroutine_fn blk_aio_pr_preempt_entry(void *opaque)
<br>&gt;&gt; +{
<br>&gt;&gt; +    BlkPrOutCB *acb = opaque;
<br>&gt;&gt; +    BlkPrOutCo *prco = &amp;acb-&gt;prco;
<br>&gt;&gt; +
<br>&gt;&gt; +    prco-&gt;ret = blk_aio_pr_do_preempt(prco-&gt;blk, prco-&gt;old_key,
<br>&gt;&gt; +                                      prco-&gt;new_key, prco-&gt;type,
<br>&gt;&gt; +                                      prco-&gt;abort);
<br>&gt;&gt; +    blk_pr_out_complete(acb);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +
<br>&gt;&gt; +BlockAIOCB *blk_aio_pr_preempt(BlockBackend *blk, uint64_t cr_key,
<br>&gt;&gt; +                               uint64_t pr_key, BlockPrType type,
<br>&gt;&gt; +                               bool abort, BlockCompletionFunc *cb,
<br>&gt;&gt; +                               void *opaque)
<br>&gt;&gt; +{
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +    return blk_aio_pr_out(blk, cr_key, pr_key, false, type, false, abort,
<br>&gt;&gt; +                          blk_aio_pr_preempt_entry, cb, opaque);
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt;  /* To be called between exactly one pair of blk_inc/dec_in_flight() */
<br>&gt;&gt;  static int coroutine_fn
<br>&gt;&gt;  blk_co_do_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes)
<br>&gt;&gt; diff --git a/block/io.c b/block/io.c
<br>&gt;&gt; index 7217cf811b..87a363c94f 100644
<br>&gt;&gt; --- a/block/io.c
<br>&gt;&gt; +++ b/block/io.c
<br>&gt;&gt; @@ -3220,6 +3220,169 @@ out:
<br>&gt;&gt;      return co.ret;
<br>&gt;&gt;  }
<br>&gt;&gt;  
<br>&gt;&gt; +int coroutine_fn bdrv_co_pr_read_keys(BlockDriverState *bs,
<br>&gt;&gt; +                 uint32_t *generation, uint32_t num_keys,
<br>&gt;&gt; +                 uint64_t *keys)
<br>&gt;&gt; +{
<br>&gt;&gt; +    BlockDriver *drv = bs-&gt;drv;
<br>&gt;&gt; +    CoroutineIOCompletion co = {
<br>&gt;&gt; +        .coroutine = qemu_coroutine_self(),
<br>&gt;&gt; +    };
<br>&gt;&gt; +
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +    assert_bdrv_graph_readable();
<br>&gt;&gt; +
<br>&gt;&gt; +    bdrv_inc_in_flight(bs);
<br>&gt;&gt; +    if (!drv || !drv-&gt;bdrv_co_pr_read_keys) {
<br>&gt;&gt; +        co.ret = -ENOTSUP;
<br>&gt;&gt; +        goto out;
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    co.ret = drv-&gt;bdrv_co_pr_read_keys(bs, generation, num_keys, keys);
<br>&gt;&gt; +out:
<br>&gt;&gt; +    bdrv_dec_in_flight(bs);
<br>&gt;&gt; +    return co.ret;
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +int coroutine_fn bdrv_co_pr_read_reservation(BlockDriverState *bs,
<br>&gt;&gt; +                 uint32_t *generation, uint64_t *key, BlockPrType *type)
<br>&gt;&gt; +{
<br>&gt;&gt; +    BlockDriver *drv = bs-&gt;drv;
<br>&gt;&gt; +    CoroutineIOCompletion co = {
<br>&gt;&gt; +        .coroutine = qemu_coroutine_self(),
<br>&gt;&gt; +    };
<br>&gt;&gt; +
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +    assert_bdrv_graph_readable();
<br>&gt;&gt; +
<br>&gt;&gt; +    bdrv_inc_in_flight(bs);
<br>&gt;&gt; +    if (!drv || !drv-&gt;bdrv_co_pr_read_reservation) {
<br>&gt;&gt; +        co.ret = -ENOTSUP;
<br>&gt;&gt; +        goto out;
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    co.ret = drv-&gt;bdrv_co_pr_read_reservation(bs, generation, key, type);
<br>&gt;&gt; +out:
<br>&gt;&gt; +    bdrv_dec_in_flight(bs);
<br>&gt;&gt; +    return co.ret;
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +int coroutine_fn bdrv_co_pr_register(BlockDriverState *bs, uint64_t old_key,
<br>&gt;&gt; +                 uint64_t new_key, BlockPrType type, bool ptpl,
<br>&gt;&gt; +                 bool ignore_key)
<br>&gt;&gt; +{
<br>&gt;&gt; +    BlockDriver *drv = bs-&gt;drv;
<br>&gt;&gt; +    CoroutineIOCompletion co = {
<br>&gt;&gt; +        .coroutine = qemu_coroutine_self(),
<br>&gt;&gt; +    };
<br>&gt;&gt; +
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +    assert_bdrv_graph_readable();
<br>&gt;&gt; +
<br>&gt;&gt; +    bdrv_inc_in_flight(bs);
<br>&gt;&gt; +    if (!drv || !drv-&gt;bdrv_co_pr_register) {
<br>&gt;&gt; +        co.ret = -ENOTSUP;
<br>&gt;&gt; +        goto out;
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    co.ret = drv-&gt;bdrv_co_pr_register(bs, old_key, new_key, type,
<br>&gt;&gt; +    ptpl, ignore_key);
<br>&gt;&gt; +out:
<br>&gt;&gt; +    bdrv_dec_in_flight(bs);
<br>&gt;&gt; +    return co.ret;
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +int coroutine_fn bdrv_co_pr_reserve(BlockDriverState *bs, uint64_t key,
<br>&gt;&gt; +                                    BlockPrType type)
<br>&gt;&gt; +{
<br>&gt;&gt; +    BlockDriver *drv = bs-&gt;drv;
<br>&gt;&gt; +    CoroutineIOCompletion co = {
<br>&gt;&gt; +        .coroutine = qemu_coroutine_self(),
<br>&gt;&gt; +    };
<br>&gt;&gt; +
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +    assert_bdrv_graph_readable();
<br>&gt;&gt; +
<br>&gt;&gt; +    bdrv_inc_in_flight(bs);
<br>&gt;&gt; +    if (!drv || !drv-&gt;bdrv_co_pr_reserve) {
<br>&gt;&gt; +        co.ret = -ENOTSUP;
<br>&gt;&gt; +        goto out;
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    co.ret = drv-&gt;bdrv_co_pr_reserve(bs, key, type);
<br>&gt;&gt; +out:
<br>&gt;&gt; +    bdrv_dec_in_flight(bs);
<br>&gt;&gt; +    return co.ret;
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +int coroutine_fn bdrv_co_pr_release(BlockDriverState *bs, uint64_t key,
<br>&gt;&gt; +                                    BlockPrType type)
<br>&gt;&gt; +{
<br>&gt;&gt; +    BlockDriver *drv = bs-&gt;drv;
<br>&gt;&gt; +    CoroutineIOCompletion co = {
<br>&gt;&gt; +        .coroutine = qemu_coroutine_self(),
<br>&gt;&gt; +    };
<br>&gt;&gt; +
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +    assert_bdrv_graph_readable();
<br>&gt;&gt; +
<br>&gt;&gt; +    bdrv_inc_in_flight(bs);
<br>&gt;&gt; +    if (!drv || !drv-&gt;bdrv_co_pr_release) {
<br>&gt;&gt; +        co.ret = -ENOTSUP;
<br>&gt;&gt; +        goto out;
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    co.ret = drv-&gt;bdrv_co_pr_release(bs, key, type);
<br>&gt;&gt; +out:
<br>&gt;&gt; +    bdrv_dec_in_flight(bs);
<br>&gt;&gt; +    return co.ret;
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +int coroutine_fn bdrv_co_pr_clear(BlockDriverState *bs, uint64_t key)
<br>&gt;&gt; +{
<br>&gt;&gt; +    BlockDriver *drv = bs-&gt;drv;
<br>&gt;&gt; +    CoroutineIOCompletion co = {
<br>&gt;&gt; +        .coroutine = qemu_coroutine_self(),
<br>&gt;&gt; +    };
<br>&gt;&gt; +
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +    assert_bdrv_graph_readable();
<br>&gt;&gt; +
<br>&gt;&gt; +    bdrv_inc_in_flight(bs);
<br>&gt;&gt; +    if (!drv || !drv-&gt;bdrv_co_pr_clear) {
<br>&gt;&gt; +        co.ret = -ENOTSUP;
<br>&gt;&gt; +        goto out;
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    co.ret = drv-&gt;bdrv_co_pr_clear(bs, key);
<br>&gt;&gt; +out:
<br>&gt;&gt; +    bdrv_dec_in_flight(bs);
<br>&gt;&gt; +    return co.ret;
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt; +int coroutine_fn bdrv_co_pr_preempt(BlockDriverState *bs, uint64_t cr_key,
<br>&gt;&gt; +                 uint64_t pr_key, BlockPrType type, bool abort)
<br>&gt;&gt; +{
<br>&gt;&gt; +    BlockDriver *drv = bs-&gt;drv;
<br>&gt;&gt; +    CoroutineIOCompletion co = {
<br>&gt;&gt; +        .coroutine = qemu_coroutine_self(),
<br>&gt;&gt; +    };
<br>&gt;&gt; +
<br>&gt;&gt; +    IO_CODE();
<br>&gt;&gt; +    assert_bdrv_graph_readable();
<br>&gt;&gt; +
<br>&gt;&gt; +    bdrv_inc_in_flight(bs);
<br>&gt;&gt; +    if (!drv || !drv-&gt;bdrv_co_pr_preempt) {
<br>&gt;&gt; +        co.ret = -ENOTSUP;
<br>&gt;&gt; +        goto out;
<br>&gt;&gt; +    }
<br>&gt;&gt; +
<br>&gt;&gt; +    co.ret = drv-&gt;bdrv_co_pr_preempt(bs, cr_key, pr_key, type, abort);
<br>&gt;&gt; +out:
<br>&gt;&gt; +    bdrv_dec_in_flight(bs);
<br>&gt;&gt; +    return co.ret;
<br>&gt;&gt; +}
<br>&gt;&gt; +
<br>&gt;&gt;  int coroutine_fn bdrv_co_zone_report(BlockDriverState *bs, int64_t offset,
<br>&gt;&gt;                          unsigned int *nr_zones,
<br>&gt;&gt;                          BlockZoneDescriptor *zones)
<br>&gt;&gt; diff --git a/include/block/block-common.h b/include/block/block-common.h
<br>&gt;&gt; index a846023a09..7ca4e2328f 100644
<br>&gt;&gt; --- a/include/block/block-common.h
<br>&gt;&gt; +++ b/include/block/block-common.h
<br>&gt;&gt; @@ -524,6 +524,46 @@ typedef enum {
<br>&gt;&gt;      BDRV_FIX_ERRORS   = 2,
<br>&gt;&gt;  } BdrvCheckMode;
<br>&gt;&gt;  
<br>&gt;&gt; +/**
<br>&gt;&gt; + *  According SCSI protocol(chapter 5.9 of SCSI Primary Commands - 4)
<br>&gt;&gt; + *  and NVMe protocol(chapter 7.2 of NVMe Base Specification 2.0),
<br>&gt;&gt; + *  the persistent reservation types and persistent capabilities of
<br>&gt;&gt; + *  the public layer block are abstracted.
<br>&gt;&gt; + */
<br>&gt;&gt; +typedef enum {
<br>&gt;&gt; +    BLK_PR_WRITE_EXCLUSIVE              = 0x1,
<br>&gt;&gt; +    BLK_PR_EXCLUSIVE_ACCESS             = 0x2,
<br>&gt;&gt; +    BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY    = 0x3,
<br>&gt;&gt; +    BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY   = 0x4,
<br>&gt;&gt; +    BLK_PR_WRITE_EXCLUSIVE_ALL_REGS     = 0x5,
<br>&gt;&gt; +    BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS    = 0x6,
<br>&gt;&gt; +} BlockPrType;
<br>&gt;&gt; +
<br>&gt;&gt; +typedef enum BLKPrCap {
<br>&gt;&gt; +    /* Persist Through Power Loss */
<br>&gt;&gt; +    BLK_PR_CAP_PTPL = 1 &lt;&lt; 0,
<br>&gt;&gt; +    /* Write Exclusive reservation type */
<br>&gt;&gt; +    BLK_PR_CAP_WR_EX = 1 &lt;&lt; 1,
<br>&gt;&gt; +    /* Exclusive Access reservation type */
<br>&gt;&gt; +    BLK_PR_CAP_EX_AC = 1 &lt;&lt; 2,
<br>&gt;&gt; +    /* Write Exclusive Registrants Only reservation type */
<br>&gt;&gt; +    BLK_PR_CAP_WR_EX_RO = 1 &lt;&lt; 3,
<br>&gt;&gt; +    /* Exclusive Access Registrants Only reservation type */
<br>&gt;&gt; +    BLK_PR_CAP_EX_AC_RO = 1 &lt;&lt; 4,
<br>&gt;&gt; +    /* Write Exclusive All Registrants reservation type */
<br>&gt;&gt; +    BLK_PR_CAP_WR_EX_AR = 1 &lt;&lt; 5,
<br>&gt;&gt; +    /* Exclusive Access All Registrants reservation type */
<br>&gt;&gt; +    BLK_PR_CAP_EX_AC_AR = 1 &lt;&lt; 6,
<br>&gt;&gt; +
<br>&gt;&gt; +    BLK_PR_CAP_ALL = (BLK_PR_CAP_PTPL |
<br>&gt;&gt; +                     BLK_PR_CAP_WR_EX |
<br>&gt;&gt; +                     BLK_PR_CAP_EX_AC |
<br>&gt;&gt; +                     BLK_PR_CAP_WR_EX_RO |
<br>&gt;&gt; +                     BLK_PR_CAP_EX_AC_RO |
<br>&gt;&gt; +                     BLK_PR_CAP_WR_EX_AR |
<br>&gt;&gt; +                     BLK_PR_CAP_EX_AC_AR),
<br>&gt;&gt; +} BLKPrCap;
<br>&gt;&gt; +
<br>&gt;&gt;  typedef struct BlockSizes {
<br>&gt;&gt;      uint32_t phys;
<br>&gt;&gt;      uint32_t log;
<br>&gt;&gt; diff --git a/include/block/block-io.h b/include/block/block-io.h
<br>&gt;&gt; index b49e0537dd..908361862b 100644
<br>&gt;&gt; --- a/include/block/block-io.h
<br>&gt;&gt; +++ b/include/block/block-io.h
<br>&gt;&gt; @@ -106,6 +106,26 @@ void bdrv_aio_cancel_async(BlockAIOCB *acb);
<br>&gt;&gt;  int coroutine_fn GRAPH_RDLOCK
<br>&gt;&gt;  bdrv_co_ioctl(BlockDriverState *bs, int req, void *buf);
<br>&gt;&gt;  
<br>&gt;&gt; +int coroutine_fn GRAPH_RDLOCK
<br>&gt;&gt; +bdrv_co_pr_read_keys(BlockDriverState *bs, uint32_t *generation,
<br>&gt;&gt; +                     uint32_t num_keys, uint64_t *keys);
<br>&gt;&gt; +int coroutine_fn GRAPH_RDLOCK
<br>&gt;&gt; +bdrv_co_pr_read_reservation(BlockDriverState *bs, uint32_t *generation,
<br>&gt;&gt; +                            uint64_t *key, BlockPrType *type);
<br>&gt;&gt; +int coroutine_fn GRAPH_RDLOCK
<br>&gt;&gt; +bdrv_co_pr_register(BlockDriverState *bs, uint64_t old_key,
<br>&gt;&gt; +                    uint64_t new_key, BlockPrType type,
<br>&gt;&gt; +                    bool ptpl, bool ignore_key);
<br>&gt;&gt; +int coroutine_fn GRAPH_RDLOCK
<br>&gt;&gt; +bdrv_co_pr_reserve(BlockDriverState *bs, uint64_t key, BlockPrType type);
<br>&gt;&gt; +int coroutine_fn GRAPH_RDLOCK
<br>&gt;&gt; +bdrv_co_pr_release(BlockDriverState *bs, uint64_t key, BlockPrType type);
<br>&gt;&gt; +int coroutine_fn GRAPH_RDLOCK
<br>&gt;&gt; +bdrv_co_pr_clear(BlockDriverState *bs, uint64_t key);
<br>&gt;&gt; +int coroutine_fn GRAPH_RDLOCK
<br>&gt;&gt; +bdrv_co_pr_preempt(BlockDriverState *bs, uint64_t cr_key, uint64_t pr_key,
<br>&gt;&gt; +                   BlockPrType type, bool abort);
<br>&gt;&gt; +
<br>&gt;&gt;  /* Ensure contents are flushed to disk.  */
<br>&gt;&gt;  int coroutine_fn GRAPH_RDLOCK bdrv_co_flush(BlockDriverState *bs);
<br>&gt;&gt;  
<br>&gt;&gt; diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
<br>&gt;&gt; index 761276127e..6e628069e9 100644
<br>&gt;&gt; --- a/include/block/block_int-common.h
<br>&gt;&gt; +++ b/include/block/block_int-common.h
<br>&gt;&gt; @@ -766,6 +766,87 @@ struct BlockDriver {
<br>&gt;&gt;      int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_ioctl)(
<br>&gt;&gt;          BlockDriverState *bs, unsigned long int req, void *buf);
<br>&gt;&gt;  
<br>&gt;&gt; +    /*
<br>&gt;&gt; +     * Persistent reservation series api.
<br>&gt;&gt; +     * Please refer to chapter 5.9 of SCSI Primary Commands - 4 or
<br>&gt;&gt; +     * chapter 7 of NVMe Base Specification 2.0.
<br>&gt;&gt; +     *
<br>&gt;&gt; +     * The block layer driver should implement all the following APIs
<br>&gt;&gt; +     * or none at all, including: bdrv_co_pr_read_keys,
<br>&gt;&gt; +     * bdrv_co_pr_read_reservation, bdrv_co_pr_register,
<br>&gt;&gt; +     * bdrv_co_pr_reserve, bdrv_co_pr_release,
<br>&gt;&gt; +     * bdrv_co_pr_clear and bdrv_co_pr_preempt.
<br>&gt;&gt; +     *
<br>&gt;&gt; +     * Read the registered keys and return them in the @keys.
<br>&gt;&gt; +     * @generation: The generation of the reservation key.
<br>&gt;&gt; +     * @num_keys:   The maximum number of keys that can be transmitted.
<br>&gt;&gt; +     * @keys:       Registered keys array.
<br>&gt;&gt; +     *
<br>&gt;&gt; +     * On success, store generation in @generation and store keys @keys
<br>&gt;&gt; +     * and return the number of @keys.
<br>&gt;&gt; +     * On failure return -errno.
<br>&gt;&gt; +     */
<br>&gt;&gt; +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_read_keys)(
<br>&gt;&gt; +        BlockDriverState *bs, uint32_t *generation,
<br>&gt;&gt; +        uint32_t num_keys, uint64_t *keys);
<br>&gt;&gt; +    /*
<br>&gt;&gt; +     * Read the reservation key and store it in the @key.
<br>&gt;&gt; +     * @generation: The generation of the reservation key.
<br>&gt;&gt; +     * @key:        The reservation key.
<br>&gt;&gt; +     * @type:       Type of the reservation key.
<br>&gt;&gt; +     *
<br>&gt;&gt; +     * On success, store generation in @generation, store the
<br>&gt;&gt; +     * reservation key in @key and return the number of @key
<br>&gt;&gt; +     * which used to determine whether the reservation key exists.
<br>&gt;&gt; +     * On failure return -errno.
<br>&gt;&gt; +     */
<br>&gt;&gt; +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_read_reservation)(
<br>&gt;&gt; +        BlockDriverState *bs, uint32_t *generation,
<br>&gt;&gt; +        uint64_t *key, BlockPrType *type);
<br>&gt;&gt; +    /*
<br>&gt;&gt; +     * Register, unregister, or replace a reservation key.
<br>&gt;&gt; +     * @old_key:    The current reservation key associated with the host.
<br>&gt;&gt; +     * @new_key:    The new reservation Key.
<br>&gt;&gt; +     * @type:       Type of the reservation key.
<br>&gt;&gt; +     * @ignore_key: Ignore or not @old_key.
<br>&gt;&gt; +     * @ptpl:       Whether to support Persist Through Power Loss(PTPL).
<br>&gt;&gt; +     */
<br>&gt;&gt; +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_register)(
<br>&gt;&gt; +        BlockDriverState *bs, uint64_t old_key,
<br>&gt;&gt; +        uint64_t new_key, BlockPrType type,
<br>&gt;&gt; +        bool ptpl, bool ignore_key);
<br>&gt;&gt; +    /*
<br>&gt;&gt; +     * Acquire a reservation on a host.
<br>&gt;&gt; +     * @key:  The current reservation key associated with the host.
<br>&gt;&gt; +     * @type: Type of the reservation key.
<br>&gt;&gt; +     */
<br>&gt;&gt; +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_reserve)(
<br>&gt;&gt; +        BlockDriverState *bs, uint64_t key, BlockPrType type);
<br>&gt;&gt; +    /*
<br>&gt;&gt; +     * Release a reservation on a host.
<br>&gt;&gt; +     * @key:  The current reservation key associated with the host.
<br>&gt;&gt; +     * @type: Type of the reservation key.
<br>&gt;&gt; +     */
<br>&gt;&gt; +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_release)(
<br>&gt;&gt; +        BlockDriverState *bs, uint64_t key, BlockPrType type);
<br>&gt;&gt; +    /**
<br>&gt;&gt; +     * Clear reservations on a host.
<br>&gt;&gt; +     * @key: The current reservation key associated with the host.
<br>&gt;&gt; +     */
<br>&gt;&gt; +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_clear)(
<br>&gt;&gt; +        BlockDriverState *bs, uint64_t key);
<br>&gt;&gt; +    /*
<br>&gt;&gt; +     * Preempt a reservation held on a host.
<br>&gt;&gt; +     * @cr_key: The current reservation key associated with the host.
<br>&gt;&gt; +     * @pr_key: The preempt reservation Key which to be
<br>&gt;&gt; +     *          unregistered from the namespace.
<br>&gt;&gt; +     * @type:   Type of the reservation key.
<br>&gt;&gt; +     * @abort:  Whether to abort a reservation held on a host.
<br>&gt;&gt; +     */
<br>&gt;&gt; +    int coroutine_fn GRAPH_RDLOCK_PTR(*bdrv_co_pr_preempt)(
<br>&gt;&gt; +        BlockDriverState *bs, uint64_t cr_key,
<br>&gt;&gt; +        uint64_t pr_key, BlockPrType type, bool abort);
<br>&gt;&gt; +
<br>&gt;&gt;      /*
<br>&gt;&gt;       * Returns 0 for completed check, -errno for internal errors.
<br>&gt;&gt;       * The check results are stored in result.
<br>&gt;&gt; @@ -899,6 +980,9 @@ typedef struct BlockLimits {
<br>&gt;&gt;      uint32_t max_active_zones;
<br>&gt;&gt;  
<br>&gt;&gt;      uint32_t write_granularity;
<br>&gt;&gt; +
<br>&gt;&gt; +   /* Persistent reservation capacities. */
<br>&gt;&gt; +    uint8_t pr_cap;
<br>&gt;&gt;  } BlockLimits;
<br>&gt;&gt;  
<br>&gt;&gt;  typedef struct BdrvOpBlocker BdrvOpBlocker;
<br>&gt;&gt; diff --git a/include/sysemu/block-backend-io.h b/include/sysemu/block-backend-io.h
<br>&gt;&gt; index d174275a5c..b3d49a3c6f 100644
<br>&gt;&gt; --- a/include/sysemu/block-backend-io.h
<br>&gt;&gt; +++ b/include/sysemu/block-backend-io.h
<br>&gt;&gt; @@ -62,6 +62,30 @@ void blk_aio_cancel_async(BlockAIOCB *acb);
<br>&gt;&gt;  BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
<br>&gt;&gt;                            BlockCompletionFunc *cb, void *opaque);
<br>&gt;&gt;  
<br>&gt;&gt; +BlockAIOCB *blk_aio_pr_read_keys(BlockBackend *blk, uint32_t *generation,
<br>&gt;&gt; +                                 uint32_t num_keys, uint64_t *keys,
<br>&gt;&gt; +                                 BlockCompletionFunc *cb, void *opaque);
<br>&gt;&gt; +BlockAIOCB *blk_aio_pr_read_reservation(BlockBackend *blk, uint32_t *generation,
<br>&gt;&gt; +                                        uint64_t *key, BlockPrType *type,
<br>&gt;&gt; +                                        BlockCompletionFunc *cb, void *opaque);
<br>&gt;&gt; +BlockAIOCB *blk_aio_pr_register(BlockBackend *blk, uint64_t old_key,
<br>&gt;&gt; +                                uint64_t new_key, BlockPrType type,
<br>&gt;&gt; +                                bool ptpl, bool ignore_key,
<br>&gt;&gt; +                                BlockCompletionFunc *cb,
<br>&gt;&gt; +                                void *opaque);
<br>&gt;&gt; +BlockAIOCB *blk_aio_pr_reserve(BlockBackend *blk,  uint64_t key,
<br>&gt;&gt; +                               BlockPrType type,
<br>&gt;&gt; +                               BlockCompletionFunc *cb,
<br>&gt;&gt; +                               void *opaque);
<br>&gt;&gt; +BlockAIOCB *blk_aio_pr_release(BlockBackend *blk, uint64_t key,
<br>&gt;&gt; +                               BlockPrType type, BlockCompletionFunc *cb,
<br>&gt;&gt; +                               void *opaque);
<br>&gt;&gt; +BlockAIOCB *blk_aio_pr_clear(BlockBackend *blk, uint64_t key,
<br>&gt;&gt; +                             BlockCompletionFunc *cb, void *opaque);
<br>&gt;&gt; +BlockAIOCB *blk_aio_pr_preempt(BlockBackend *blk, uint64_t cr_key,
<br>&gt;&gt; +                               uint64_t pr_key, BlockPrType type, bool abort,
<br>&gt;&gt; +                               BlockCompletionFunc *cb, void *opaque);
<br>&gt;&gt; +
<br>&gt;&gt;  void blk_inc_in_flight(BlockBackend *blk);
<br>&gt;&gt;  void blk_dec_in_flight(BlockBackend *blk);
<br>&gt;&gt;  
<br>&gt;&gt; -- 
<br>&gt;&gt; 2.20.1
<br>&gt;&gt;</p>

--000000000000af0140061a944049--

