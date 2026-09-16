Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353A1C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kqL-0001kr-60; Wed, 16 Sep 2026 04:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x6kqG-0001kW-0Q
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x6kqC-0000Al-Qd
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789546683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qfjNHRQkFwrTeCqysdjoBYns8txaeAKMSx5QhQnqGDk=;
 b=Y7SnGkcsJgUSu1KVZngNSArJkQz4djylQqKL1YfYZ5Bjfz4DZWnVBVbhFvASXpACcYRGvk
 DQbyK6pMe7ZmQ1fDG3s9nuMV0yzwK3sBySUxAdNPmgLZo3byUJRQcocKPWYUMKN9AGSrCc
 oq3AA3Cw6JctMfMzGGPl2nnnFb4eWEg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-RAvW80m0NC-8GD022Jhbgg-1; Wed, 16 Sep 2026 04:18:01 -0400
X-MC-Unique: RAvW80m0NC-8GD022Jhbgg-1
X-Mimecast-MFC-AGG-ID: RAvW80m0NC-8GD022Jhbgg_1789546681
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6a9a19c8bdbso2914009a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 01:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789546680; x=1790151480; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qfjNHRQkFwrTeCqysdjoBYns8txaeAKMSx5QhQnqGDk=;
 b=kgl0E+96Sdo3LwzgPZmegD4wIMIZ+m/mIvHJaJ60hpWpy3Rd6iql373XpwdT/o4n1a
 SyMndmgXUhmSIIrEdLS4kdFOosqjTK05yq3UA848r4f5MyeVyd3uv/BYFdvlyifhJomj
 JiaabABGXZBimLKdT9Gu838njth3g8lpWco6gw7bMejtmMoag2sDMI3nPUKhwe5Ww12i
 3OtYOBMEdoAgciF9qaevXRweSNXxCOczSKelxM3reoBrT/hUI2SeTa3YE5g3rmqgmaO3
 /lm1LQPgK9VfG+1m61jbFGh/oCRMPO37xUKxWJPp2VXCU/66lS6b1E6go18XpdaeCepR
 yOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789546680; x=1790151480;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qfjNHRQkFwrTeCqysdjoBYns8txaeAKMSx5QhQnqGDk=;
 b=Mn2fbVSOc5wkGhVWQSw7pCVl2fuR8cr47QolJpEx2ZPHk/ZUyBeSBfvxAxU+Yr/6da
 7Cur3vzfW4WkDIBn1ELQAHnBGxkTVEsNy4USCsOC7pqeV4rqs524oQquao/A5tGjQzwV
 4BF8XgCZHOeQYXkh8/h1dq4rkUNToOrnmxPs7sL0TWzPCORU5T/ByjGwPk0dYFCCTPBV
 5zZdCZy6yxIgiRmTEpZVYhxyVT4aKXVvxrkeul/t+JtPce7Uky5n3Pzh6xZU9W0aFYfi
 7XQOET0uWsN6f78c+fTodUbcKGSQ4+ou1r+Rt+PlfVjWsqM4RcCYJQps7Ra/JMM85/rh
 dcbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxb58c+FEI9pz+JVFCG8KFUN5t4zocJd0spaogUZJr20hKoG/A0tpB2rFFBgWnsIZhh02QSox/nebOa@nongnu.org
X-Gm-Message-State: AFuF++lF+Bxbruje1qFvVxg068YQzT62AYfXbOmb8A5AgTiw9orXpNB9
 MWG0u0i2JjZhJ8jfuJRjWivsi45bX4po6mkbPUw/aRNKpvjO+IWSnZStbVfNISvdDOyl/fILjGh
 WIu+lPeCwvJgoodTcrfXy1rd2EFzgykwNHRQM9QvVfoY5Qy5lZFEAX7BH
X-Gm-Gg: AYBFou2I/NbFOAJE1ec4ALXEU0nTM7CQsgcaCxr+MNKJ69espqB5MyS0PEhuwQzHJo8
 3dZ5bNwhfJh8rG2kZO4aN4tUTSHED/GQIEzQsU5cAXwK/bifS16mNrbbIUL4WBse9ZlDpuE/Ey+
 KRnFigGeCk43pGdz4xbzmI4+B8GDbBe4J2RS91VZI5b4BN0dHMvH3wIaZEZHQ8Z8uaFq2Rj0Y5H
 hLLdTr9CH8OFwrpFLSlz8oIMMI6rGiLjmKeiIHGqjLUgZ2MxZ/TyQ+89iKtRySMWHHZL2XlVrub
 afwesOXXCRZR8B2XJ0kSNyD7PZz9X9PIN/T3gGYpjNO+fz2aQ3lksSZOuRS8GCVoub357Rwq/Kt
 GEXlEkJWhsoF9LzmPhnj/TbSYWpKJZ+C5ID1HpNXbi+uDYNCLwtFqO/VVUxuE+fVlmQ2fwunBOi
 1A1JiloCHs2LYShBZExWS5Y3WL7f8=
X-Received: by 2002:a05:6402:2747:b0:69e:2ca5:53bb with SMTP id
 4fb4d7f45d1cf-6aa22681579mr1213540a12.0.1789546680607; 
 Wed, 16 Sep 2026 01:18:00 -0700 (PDT)
X-Received: by 2002:a05:6402:2747:b0:69e:2ca5:53bb with SMTP id
 4fb4d7f45d1cf-6aa22681579mr1213517a12.0.1789546680171; 
 Wed, 16 Sep 2026 01:18:00 -0700 (PDT)
Received: from ?IPV6:2003:cf:d704:f6c1:9398:5dbc:cc8:753b?
 (p200300cfd704f6c193985dbc0cc8753b.dip0.t-ipconnect.de.
 [2003:cf:d704:f6c1:9398:5dbc:cc8:753b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d228bccsm1142856a12.7.2026.09.16.01.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 01:17:59 -0700 (PDT)
Message-ID: <cc6bfc83-457e-40c3-a263-0cde3c65f5d3@redhat.com>
Date: Wed, 16 Sep 2026 10:17:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] block: Add delay-alert-ms property
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-8-hreitz@redhat.com> <20260903143055.GE825275@fedora>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260903143055.GE825275@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
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

On 03.09.26 16:30, Stefan Hajnoczi wrote:
> On Mon, Aug 31, 2026 at 03:52:03PM +0200, Hanna Czenczek wrote:
>> This device property allows setting up an I/O latency threshold for when
>> to emit a delay QMP event.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   include/hw/block/block.h   |  5 ++++-
>>   blockdev.c                 | 16 +++++++++++++++-
>>   hw/block/block.c           |  4 +++-
>>   tests/qemu-iotests/172.out | 38 ++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 60 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/hw/block/block.h b/include/hw/block/block.h
>> index df941df19f2..e7e401dd303 100644
>> --- a/include/hw/block/block.h
>> +++ b/include/hw/block/block.h
>> @@ -36,6 +36,7 @@ typedef struct BlockConf {
>>       BlockdevOnError werror;
>>       uint32_t num_stats_intervals;
>>       uint32_t *stats_intervals;
>> +    uint32_t delay_alert_ms;
>>   } BlockConf;
>>   
>>   static inline unsigned int get_physical_block_exp(BlockConf *conf)
>> @@ -83,7 +84,9 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
>>                               _conf.account_failed, ON_OFF_AUTO_AUTO),    \
>>       DEFINE_PROP_ARRAY("stats-intervals", _state,                        \
>>                        _conf.num_stats_intervals, _conf.stats_intervals,  \
>> -                     qdev_prop_uint32, uint32_t)
>> +                     qdev_prop_uint32, uint32_t),                       \
>> +    DEFINE_PROP_UINT32("delay-alert-ms", _state, _conf.delay_alert_ms,  \
>> +                       0)                                               \
> The latency histogram feature uses nanoseconds (64-bit integer) whereas
> this patch series uses delay-alert-ms (uint32) and a double
> floating-point seconds value in the QMP event. Maybe stick to 64-bit
> integer nanoseconds everywhere for consistency?

I don’t have technical objections because doing so is easy, of course. 
Personally, I found nanoseconds really unwieldy to specify here. But I 
suppose if @block-latency-histogram-set does the same, then I might as well.

Hanna

>>   
>>   #define DEFINE_BLOCK_PROPERTIES(_state, _conf)                          \
>>       DEFINE_PROP_DRIVE("drive", _state, _conf.blk),                      \
>> diff --git a/blockdev.c b/blockdev.c
>> index 195bac8af01..9c76e89ef38 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -496,6 +496,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
>>       BlockdevDetectZeroesOptions detect_zeroes =
>>           BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF;
>>       const char *throttling_group = NULL;
>> +    uint64_t delay_alert_ns;
>>   
>>       /* Check common options by copying from bs_opts to opts, all other options
>>        * stay in bs_opts for processing by bdrv_open(). */
>> @@ -580,6 +581,14 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
>>   
>>       read_only = qemu_opt_get_bool(opts, BDRV_OPT_READ_ONLY, false);
>>   
>> +    delay_alert_ns = qemu_opt_get_number(opts, "delay-alert-ms", 0);
>> +    if (delay_alert_ns > (uint64_t)INT64_MAX / SCALE_MS) {
>> +        error_setg(errp, "delay-alert-ms must not exceed %" PRId64,
>> +                   INT64_MAX / SCALE_MS);
>> +        goto early_err;
>> +    }
>> +    delay_alert_ns *= SCALE_MS;
>> +
>>       /* init */
>>       if ((!file || !*file) && !qdict_size(bs_opts)) {
>>           BlockBackendRootState *blk_rs;
>> @@ -618,7 +627,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
>>           bs->detect_zeroes = detect_zeroes;
>>   
>>           block_acct_setup(blk_get_stats(blk), account_invalid, account_failed,
>> -                         NULL, 0, 0, NULL);
>> +                         NULL, 0, delay_alert_ns, NULL);
>>   
>>           if (!parse_stats_intervals(blk_get_stats(blk), interval_list, errp)) {
>>               blk_unref(blk);
>> @@ -3753,6 +3762,11 @@ QemuOptsList qemu_common_drive_opts = {
>>               .type = QEMU_OPT_BOOL,
>>               .help = "whether to account for failed I/O operations "
>>                       "in the statistics",
>> +        },{
>> +            .name = "delay-alert-ms",
>> +            .type = QEMU_OPT_NUMBER,
>> +            .help = "threshold in ms when to emit an I/O operation "
>> +                    "delay QMP event",
>>           },
>>           { /* end of list */ }
>>       },
>> diff --git a/hw/block/block.c b/hw/block/block.c
>> index 19301c6f995..be0ea89cb79 100644
>> --- a/hw/block/block.c
>> +++ b/hw/block/block.c
>> @@ -207,6 +207,7 @@ bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
>>       BlockBackend *blk = conf->blk;
>>       BlockdevOnError rerror, werror;
>>       uint64_t perm, shared_perm;
>> +    uint64_t delay_alert_ns;
>>       bool wce;
>>       int ret;
>>   
>> @@ -249,9 +250,10 @@ bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
>>       blk_set_enable_write_cache(blk, wce);
>>       blk_set_on_error(blk, rerror, werror);
>>   
>> +    delay_alert_ns = (uint64_t)conf->delay_alert_ms * SCALE_MS;
>>       if (!block_acct_setup(blk_get_stats(blk), conf->account_invalid,
>>                             conf->account_failed, conf->stats_intervals,
>> -                          conf->num_stats_intervals, 0, errp)) {
>> +                          conf->num_stats_intervals, delay_alert_ns, errp)) {
>>           return false;
>>       }
>>       return true;
>> diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
>> index a023cd407de..ea6a1875eb3 100644
>> --- a/tests/qemu-iotests/172.out
>> +++ b/tests/qemu-iotests/172.out
>> @@ -31,6 +31,7 @@ Testing:
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "288"
>>   
>>   
>> @@ -61,6 +62,7 @@ Testing: -fda TEST_DIR/t.qcow2
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>   floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/unattached/device[N]
>> @@ -98,6 +100,7 @@ Testing: -fdb TEST_DIR/t.qcow2
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>                 dev: floppy, id ""
>>                   unit = 0 (0x0)
>> @@ -113,6 +116,7 @@ Testing: -fdb TEST_DIR/t.qcow2
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "288"
>>   floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/unattached/device[N]
>> @@ -154,6 +158,7 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>                 dev: floppy, id ""
>>                   unit = 0 (0x0)
>> @@ -169,6 +174,7 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>   floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/unattached/device[N]
>> @@ -211,6 +217,7 @@ Testing: -fdb
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "288"
>>                 dev: floppy, id ""
>>                   unit = 0 (0x0)
>> @@ -226,6 +233,7 @@ Testing: -fdb
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "288"
>>   
>>   
>> @@ -256,6 +264,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>   floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/unattached/device[N]
>> @@ -293,6 +302,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>                 dev: floppy, id ""
>>                   unit = 0 (0x0)
>> @@ -308,6 +318,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "288"
>>   floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/unattached/device[N]
>> @@ -349,6 +360,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>                 dev: floppy, id ""
>>                   unit = 0 (0x0)
>> @@ -364,6 +376,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>   floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/unattached/device[N]
>> @@ -409,6 +422,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>   none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/peripheral-anon/device[N]
>> @@ -446,6 +460,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>   none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/peripheral-anon/device[N]
>> @@ -483,6 +498,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>                 dev: floppy, id ""
>>                   unit = 0 (0x0)
>> @@ -498,6 +514,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>   none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/peripheral-anon/device[N]
>> @@ -549,6 +566,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>                 dev: floppy, id ""
>>                   unit = 0 (0x0)
>> @@ -564,6 +582,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>   floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/unattached/device[N]
>> @@ -606,6 +625,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>                 dev: floppy, id ""
>>                   unit = 0 (0x0)
>> @@ -621,6 +641,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>   floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/unattached/device[N]
>> @@ -663,6 +684,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>                 dev: floppy, id ""
>>                   unit = 1 (0x1)
>> @@ -678,6 +700,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>   floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/unattached/device[N]
>> @@ -720,6 +743,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>                 dev: floppy, id ""
>>                   unit = 1 (0x1)
>> @@ -735,6 +759,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>   floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/unattached/device[N]
>> @@ -786,6 +811,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>                 dev: floppy, id ""
>>                   unit = 0 (0x0)
>> @@ -801,6 +827,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>   floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/unattached/device[N]
>> @@ -843,6 +870,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>                 dev: floppy, id ""
>>                   unit = 0 (0x0)
>> @@ -858,6 +886,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>   floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/unattached/device[N]
>> @@ -906,6 +935,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global floppy.drive=none0 -device
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>   none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/peripheral-anon/device[N]
>> @@ -973,6 +1003,7 @@ Testing: -device floppy
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "288"
>>   
>>   Testing: -device floppy,drive-type=120
>> @@ -1000,6 +1031,7 @@ Testing: -device floppy,drive-type=120
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "120"
>>   
>>   Testing: -device floppy,drive-type=144
>> @@ -1027,6 +1059,7 @@ Testing: -device floppy,drive-type=144
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>   
>>   Testing: -device floppy,drive-type=288
>> @@ -1054,6 +1087,7 @@ Testing: -device floppy,drive-type=288
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "288"
>>   
>>   
>> @@ -1084,6 +1118,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "120"
>>   none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/peripheral-anon/device[N]
>> @@ -1121,6 +1156,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "288"
>>   none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/peripheral-anon/device[N]
>> @@ -1161,6 +1197,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,logical
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>   none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/peripheral-anon/device[N]
>> @@ -1198,6 +1235,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physica
>>                   account-invalid = "auto"
>>                   account-failed = "auto"
>>                   stats-intervals = <null>
>> +                delay-alert-ms = 0 (0x0)
>>                   drive-type = "144"
>>   none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
>>       Attached to:      /machine/peripheral-anon/device[N]
>> -- 
>> 2.55.0
>>


