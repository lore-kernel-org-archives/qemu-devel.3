Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DA6C3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 13:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uETLZ-00069C-Ox; Mon, 12 May 2025 09:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uETLN-000684-KU
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uETLK-0001eS-A2
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747057034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=im2priDzq+pkcpThck918RmJAbTX7P5Kr7irLUHLzRE=;
 b=Z3pbzwvlI9UV5QjeXJussni/BF6eTekPcdRDqt5RZ3iD2Dtu+oOjscIhVS9IHC7bjrTnoA
 A5gCAboMwivTa4kkhNmxWFRbdwY/nnTBrdCM9yABM1c+hZMTPzO9o/twzaXiCtCSoxZOBa
 5XrKeTABRPiNFhNgnzVWrNfEKCNfUJs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-18ZXEf3UPDq3MG0Yo8d8DA-1; Mon, 12 May 2025 09:37:12 -0400
X-MC-Unique: 18ZXEf3UPDq3MG0Yo8d8DA-1
X-Mimecast-MFC-AGG-ID: 18ZXEf3UPDq3MG0Yo8d8DA_1747057031
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a202744565so671152f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 06:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747057031; x=1747661831;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=im2priDzq+pkcpThck918RmJAbTX7P5Kr7irLUHLzRE=;
 b=E+7aPoZ7HnUxONVGtAXREFXQn0AatFEF8ygcN89Hn/da7L0Kc50tizr08b7dGpHxOc
 a3MSAz10HAOCLYHCiIsr4TBGNCXIZyOV/04zLOrN7Oa7AJhKmJU30ZGm2UO+lEOUThNA
 Wu1xYAwKbwlifG54FeICtMbi3T/+ercH6+q+4KX0bwgBzgDkqMaSCDN0EmsLqBSfTvmu
 7FsCJDGVm4Y2ENoSLQDPyhiHOxK46BSAO09noT8HKpwtLquaG2ilcXqshlAuNCHeJ2RJ
 DNpRbmOdaCNRWcHbLcxJrVytTA4akoY7QXdH5ji/Qx8aDqKiGc5sihVLk9H4fS2A2vSK
 /56A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHoIg6Orvz7OvnufRgbh1z75LWIR+9Ik/YKtN8CxuyzupwamgcZTZOlYpXH7RnS6PTLyx3S5lTSSwA@nongnu.org
X-Gm-Message-State: AOJu0Yyao1PU9cVJvet9CciLUzDIUQsxlmnoGaOxRpjx8zS+PWTHNqSf
 1dCeE/SZ9/AIs9n8OzqUNSeh1z3AZobuu6y952ZHMUB98sTsDt6lIR6aKY8u4pDSPVeHcK327UA
 0H6oh74YvGMzHG9FgwHs2qEzwvB/m1UNYqL8WuGCKU3tmBybtiM62
X-Gm-Gg: ASbGncsbx373ql1NklA8rInKYesuOiq3cLVNeoxiDxQH4GbCzo+PDHd9P0bzyZ/Eqj1
 lT+yMlKCXRBaiohaoRVrG1vgxfBCU+p07Z3i39mC8vtuIJCAJjPjtiwkiaCYDZKP19OtXRChtJV
 lxfjRYaffcJXfMWVyJ4ngwYru5f39zEa2HNB5/SjzrhmrR5r1ynJqWCpdVHf0tW6ZMbSbOTZ5ZK
 zOxZx2FsglEzp6sHh08nZ71y2puwLNE83QWEwhT7q9JFBZYcvCBB8qn0M1wNAavMCRaWzOSiayG
 gfZSIA==
X-Received: by 2002:a05:6000:250c:b0:3a0:b978:1f2b with SMTP id
 ffacd0b85a97d-3a1f6a1bfdbmr8558665f8f.11.1747057031452; 
 Mon, 12 May 2025 06:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9oxB26TDqEQml7vAcXA48mdbt76wIvmRn7LZGaxI+9vpw60XhpWIBsUJa5v4T7ff4zHDBRw==
X-Received: by 2002:a05:6000:250c:b0:3a0:b978:1f2b with SMTP id
 ffacd0b85a97d-3a1f6a1bfdbmr8558644f8f.11.1747057031076; 
 Mon, 12 May 2025 06:37:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f3369sm12638807f8f.57.2025.05.12.06.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 06:37:10 -0700 (PDT)
Date: Mon, 12 May 2025 09:37:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org, linuxarm@huawei.com,
 fan.ni@samsung.com, Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 Arpit Kumar <arpit1.kumar@samsung.com>,
 Sweta Kumari <s5.kumari@samsung.com>,
 Vinayak Holikatti <vinayak.kh@samsung.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ajay Joshi <ajay.opensrc@micron.com>
Subject: Re: [PATCH qemu 7/8] hw/cxl/cxl-mailbox-utils: Added support for Get
 Log Capabilities (Opcode 0402h)
Message-ID: <20250512093638-mutt-send-email-mst@kernel.org>
References: <20250305092501.191929-1-Jonathan.Cameron@huawei.com>
 <20250305092501.191929-8-Jonathan.Cameron@huawei.com>
 <20250512043011-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512043011-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 12, 2025 at 04:42:41AM -0400, Michael S. Tsirkin wrote:
> On Wed, Mar 05, 2025 at 09:24:58AM +0000, Jonathan Cameron wrote:
> > From: Arpit Kumar <arpit1.kumar@samsung.com>
> > 
> > CXL spec 3.2 section 8.2.10.5.3 describes Get Log Capabilities.
> > It provides log capabilities supported by specified log.
> > 
> > Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  include/hw/cxl/cxl_device.h  | 20 ++++++++++++++++
> >  include/hw/cxl/cxl_mailbox.h |  5 ++++
> >  hw/cxl/cxl-mailbox-utils.c   | 45 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 70 insertions(+)
> > 
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index ed6cd50c67..87a376c982 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -133,6 +133,18 @@ typedef enum {
> >      CXL_MBOX_MAX = 0x20
> >  } CXLRetCode;
> >  
> > +/* types of logs */
> > +typedef enum {
> > +    CXL_LOG_COMMAND_EFFECT,
> > +    CXL_LOG_VENDOR_DEBUG,
> > +    CXL_LOG_COMPONENT_STATE_DUMP,
> > +    CXL_LOG_ERROR_CHECK_SCRUB,
> > +    CXL_LOG_MEDIA_TEST_CAPABILITY,
> > +    CXL_LOG_MEDIA_TEST_RESULTS_SHORT,
> > +    CXL_LOG_MEDIA_TEST_RESULTS_LONG,
> > +    MAX_LOG_TYPE
> > +} CXLLogType;
> > +
> >  typedef struct CXLCCI CXLCCI;
> >  typedef struct cxl_device_state CXLDeviceState;
> >  struct cxl_cmd;
> > @@ -163,6 +175,11 @@ typedef struct CXLEventLog {
> >      QSIMPLEQ_HEAD(, CXLEvent) events;
> >  } CXLEventLog;
> >  
> > +typedef struct CXLLogCapabilities {
> > +    uint32_t param_flags;
> > +    QemuUUID uuid;
> > +} CXLLogCapabilities;
> > +
> >  typedef struct CXLCCI {
> >      struct cxl_cmd cxl_cmd_set[256][256];
> >      struct cel_log {
> > @@ -171,6 +188,9 @@ typedef struct CXLCCI {
> >      } cel_log[1 << 16];
> >      size_t cel_size;
> >  
> > +    /* get log capabilities */
> > +    const CXLLogCapabilities *supported_log_cap;
> > +
> >      /* background command handling (times in ms) */
> >      struct {
> >          uint16_t opcode;
> > diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> > index 9008402d1c..8e1c7c5f15 100644
> > --- a/include/hw/cxl/cxl_mailbox.h
> > +++ b/include/hw/cxl/cxl_mailbox.h
> > @@ -16,4 +16,9 @@
> >  #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
> >  #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
> >  
> > +#define CXL_LOG_CAP_CLEAR_SUPPORTED (1 << 0)
> > +#define CXL_LOG_CAP_POPULATE_SUPPORTED (1 << 1)
> > +#define CXL_LOG_CAP_AUTO_POPULATE_SUPPORTED (1 << 2)
> > +#define CXL_LOG_CAP_PERSISTENT_COLD_RESET_SUPPORTED (1 << 3)
> > +
> >  #endif
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 299f232f26..f35fc4f112 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -81,6 +81,7 @@ enum {
> >      LOGS        = 0x04,
> >          #define GET_SUPPORTED 0x0
> >          #define GET_LOG       0x1
> > +        #define GET_LOG_CAPABILITIES   0x2
> >      FEATURES    = 0x05,
> >          #define GET_SUPPORTED 0x0
> >          #define GET_FEATURE   0x1
> > @@ -1068,6 +1069,43 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> >  
> > +static const struct CXLLogCapabilities *find_log_index(QemuUUID *uuid, CXLCCI *cci)
> > +{
> > +    for (int i = CXL_LOG_COMMAND_EFFECT; i < MAX_LOG_TYPE; i++) {
> > +        if (qemu_uuid_is_equal(uuid,
> > +            &cci->supported_log_cap[i].uuid)) {
> > +                return &cci->supported_log_cap[i];
> > +        }
> > +    }
> > +    return NULL;
> > +}
> > +
> > +/* CXL r3.2 Section 8.2.10.5.3: Get Log Capabilities (Opcode 0402h) */
> > +static CXLRetCode cmd_logs_get_log_capabilities(const struct cxl_cmd *cmd,
> > +                                                uint8_t *payload_in,
> > +                                                size_t len_in,
> > +                                                uint8_t *payload_out,
> > +                                                size_t *len_out,
> > +                                                CXLCCI *cci)
> > +{
> > +    const CXLLogCapabilities *cap;
> > +    struct {
> > +        QemuUUID uuid;
> > +    } QEMU_PACKED QEMU_ALIGNED(8) *get_log_capabilities_in = (void *)payload_in;
> > +
> > +    uint32_t *get_log_capabilities_out = (uint32_t *)payload_out;
> > +
> > +    cap = find_log_index(&get_log_capabilities_in->uuid, cci);
> > +    if (!cap) {
> > +        return CXL_MBOX_INVALID_LOG;
> > +    }
> > +
> > +    memcpy(get_log_capabilities_out, &cap->param_flags,
> > +           sizeof(cap->param_flags));
> > +    *len_out = sizeof(*get_log_capabilities_out);
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >  /* CXL r3.1 section 8.2.9.6: Features */
> >  /*
> >   * Get Supported Features output payload
> > @@ -3253,6 +3291,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
> >                                0, 0 },
> >      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> > +    [LOGS][GET_LOG_CAPABILITIES] = { "LOGS_GET_LOG_CAPABILITIES",
> > +                                     cmd_logs_get_log_capabilities, 0x10, 0 },
> >      [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
> >                                    cmd_features_get_supported, 0x8, 0 },
> >      [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
> > @@ -3512,10 +3552,15 @@ static void cxl_rebuild_cel(CXLCCI *cci)
> >      }
> >  }
> >  
> > +static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
> > +    [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = cel_uuid },
> > +};
> > +
> 
> 
> causes ci build failures:
> 
> https://gitlab.com/mstredhat/qemu/-/jobs/9999980051
> 
> ../hw/cxl/cxl-mailbox-utils.c:3556:60: error: initializer element is not constant
>      [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = cel_uuid },
>                                                             ^~~~~~~~
> ../hw/cxl/cxl-mailbox-utils.c:3556:60: note: (near initialization for ‘cxl_get_log_cap[0].uuid’)
> 
> 
> Fixed it up like this:
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index f35fc4f112..13d26e391b 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -992,9 +992,10 @@ static CXLRetCode cmd_timestamp_set(const struct cxl_cmd *cmd,
>  }
>  
>  /* CXL r3.1 Section 8.2.9.5.2.1: Command Effects Log (CEL) */
> -static const QemuUUID cel_uuid = {
> -    .data = UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79,
> +#define CEL_UUID UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, \
>                   0x96, 0xb1, 0x62, 0x3b, 0x3f, 0x17)
> +static const QemuUUID cel_uuid = {
> +    .data = CEL_UUID
>  };
>  
>  /* CXL r3.1 Section 8.2.9.5.1: Get Supported Logs (Opcode 0400h) */
> @@ -3553,7 +3554,7 @@ static void cxl_rebuild_cel(CXLCCI *cci)
>  }
>  
>  static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
> -    [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = cel_uuid },
> +    [CXL_LOG_COMMAND_EFFECT] = { .param_flags = 0, .uuid = CEL_UUID },
>  };
>  
>  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> 


Actually no, does not help either. Dropped for now.
Next patch does not depend on this one, right?

> >  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> >  {
> >      cci->payload_max = payload_max;
> >      cxl_rebuild_cel(cci);
> > +    cci->supported_log_cap = cxl_get_log_cap;
> >  
> >      cci->bg.complete_pct = 0;
> >      cci->bg.starttime = 0;
> > -- 
> > 2.43.0


