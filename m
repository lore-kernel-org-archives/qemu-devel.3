Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F13FC55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpRra-0006kU-6n; Thu, 30 Jul 2026 10:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpRrY-0006kG-Va
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wpRrV-0007CQ-O5
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785422151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wCQTtoTRdH9zJ1kguNL5vrdSyBhLtVXs7f0l5k23tCo=;
 b=dZKzwam6BnS2tKb7ZDqvzB4mP4lt41OkoKvbtKxdYTpVIttPmCuM0LunS7e9F57VL4YEIp
 vVOARA0A5kw8AE3RAdiBlWhztgug46Kw/vJXyD4x+7U2NpT1xF6N5FsIhXMoFBV0ltjhVq
 +J1awDlfAGFsYnkhkon2D9EBCkLzQro=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-oLB6cBmYMjGW1wJOjqJHfQ-1; Thu, 30 Jul 2026 10:35:48 -0400
X-MC-Unique: oLB6cBmYMjGW1wJOjqJHfQ-1
X-Mimecast-MFC-AGG-ID: oLB6cBmYMjGW1wJOjqJHfQ_1785422147
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4957287363bso14184935e9.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785422147; x=1786026947; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wCQTtoTRdH9zJ1kguNL5vrdSyBhLtVXs7f0l5k23tCo=;
 b=TVTG3d0GL/auLb/BLT8H1NvrrS/OyD2dsjFo+DXteRF7AppsAAJ75y9H1it4mHBgrZ
 5PlCMrsrrLEIEuR82n3MirULPq1MwbLuzyQPrrbwGMn4Bo2+snvUEYqsinbxvq5j4FIn
 pIfLgeiKJ/Aah+oNEc38KK+r70NcQQdhM9s7RyfmL+069/gOee58Xn7iT+qJMa12HhX6
 HYNO972HKT+O4wkgDWjLj9whSenPi5hmnoveDk8I/moEntkSQb50QC+xd0C7GsKlkPFA
 o0/akqfYxnq4qVeI9uTIQynzcQt/KOFZez8RLiNMUigCXgyKHMrkiwqq8F/etNurWagj
 wwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785422147; x=1786026947;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wCQTtoTRdH9zJ1kguNL5vrdSyBhLtVXs7f0l5k23tCo=;
 b=bx0T505dtQk0ftXVc2nt8Tnm+sG5HhGIgR8fsq4+b5N0qGpm2788L+Sfzb2ohHlpoY
 j0GR0o3UldUXEKr3+KqI8uusbcvz6LHWS0XBkrc44SSkspHBwbGW/HNjtKgt6plMZNo5
 AddxxerzuYtGrNG1tAalQdxIwDuFm/Oz4kGUSLyXXl0KpLWtuVxOOJKgZF8RwuoI7sSE
 mV4dhqmWKNvY525mkcI3YA4Bi2METmzCJ4aAnQwltTtMZQe95TPr3KFXdxLKUESfMexI
 HczKfLCzxDnfBPSEW9K/nlHQmQeCzYwMf8pj0IjlQo5PjYkyDdEkYA9weTLs4Mpdl4iN
 AyTA==
X-Gm-Message-State: AOJu0YxsmUdHY9bhQFn5vDwJkEvcNjQGhVoLPyHPCKap5MYcL3UeBnVu
 lpW6+IQ0GAZ5rD1aYBTUkAmL2fqyKO3ftTFG9p2hsmmXRmRHYKmSrdJv6fRQMvl6uTt37/b2Cj8
 vkG9HFq7kMw8uLOPOTS0mNGCb/6PA+QpdPOIRk1u+s6WQmLdXaq1H+QuYXcd80vzVinY=
X-Gm-Gg: AR+sD11S6+h3VAof/6THg9uoVGwUnKiMMNUpZX+BLh5rqsLYsHIt4RuGcdqWxxnd5IV
 N88723m9d67i5q200xTkNuI3xPX0WNjPT462RgvJyr20214UuF2al8ym+5e92IGhP0F9kCHNjm6
 cWNACtBXE0ziR4uA0G/UUOfswLAAWDoRy/mzXrZ1y7SNlJ3vlVFj+3/ybIghoGkJYI8lu0jaTxQ
 fjwqga93lzLBk7BzrOheOvVQbxO8EMfXuzfJL8ZcPwVmDzpREJuiR+nBi5kIumRdcWhkhkx0KD7
 wVi/zshk+qOdMJibKlcqbxpKYx8IO9fdp98xvl57x9mmSAKMLfEoEXclMN7W20igoGlNi0i0ZcM
 mWEntzpZgBdMbBwFu05BVcZQ=
X-Received: by 2002:a05:600c:80c1:b0:495:737a:7afe with SMTP id
 5b1f17b1804b1-49800e7559fmr24107255e9.15.1785422146777; 
 Thu, 30 Jul 2026 07:35:46 -0700 (PDT)
X-Received: by 2002:a05:600c:80c1:b0:495:737a:7afe with SMTP id
 5b1f17b1804b1-49800e7559fmr24106875e9.15.1785422146099; 
 Thu, 30 Jul 2026 07:35:46 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88e4721sm5476884f8f.16.2026.07.30.07.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 07:35:43 -0700 (PDT)
Date: Thu, 30 Jul 2026 10:35:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH 2/4] migration: Introduce VMStateOffset
Message-ID: <20260730101353-mutt-send-email-mst@kernel.org>
References: <20260729225227.1170574-1-farosas@suse.de>
 <20260729225227.1170574-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729225227.1170574-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Wed, Jul 29, 2026 at 07:52:25PM -0300, Fabiano Rosas wrote:
> When migrating a buffer or array, the vmstate code needs to know the
> size of the buffer and the number of elements of the array. Today a
> vmstate writer can choose from a number of macros that take as last
> input the name of a struct member from where the size/num will be
> read.
> 
> At load time, the code will access those value via an opaque pointer
> to the migrated data and therefore it needs to also know the size of
> the struct member at that offset.
> 
> Currently that information is communicated by means of the
> VMS_VARRAY_* and VMS_VBUFFER_* flags, where each possible type is
> represented by a flag.
> 
> So far, that's all fine, but since the vmstate code makes heavy use of
> macros, handling several types individually (i.e. by name: int,
> int32_t, etc) requires several versions of a same macro, one for each
> type. E.g: VMSTATE_VBUFFER_ALLOC_UINT32
>                                  ^
> 
> This creates a pattern where the vmstate writer has to match the macro
> name to the data type and has resulted in the code having a tendency
> of having one macro version for each type, for each type of vmstate.
> 
> There is also some cognitive load to deal with, e.g.
> VMSTATE_VARRAY_INT32 doesn't hold an array of int32, it holds an array
> of something else and the number of elements for the array is stored
> in a variable of type int32.
> 
> We're now dealing with the scenario where the code has been expecting
> int32_t at some places, but a uint64_t macro variant has been added
> without the code being updated.
> 
> To address all these situations, introduce a new struct that will hold
> the offset of the struct members, but also their size, so the various
> extra macros can all be removed and the person writing the vmstate
> doesn't need to care about type-checking. Still, keep a minimum check
> that those fields are at least integers and fit into 64 bits.
> 
> What changes:
> 
> 1) type checking changes from individual types to a single check for
>    all integers;
> 
> 2) there are new ways to access the offsets;
> 
> num_offset -> num_offset.off
> size_offset -> size_offset.off
> [new] num_offset.size
> [new] size_offset.size
> 
> 2) reading the offsets goes from checking the VMS_VARRAY_* flags in an
>    if/elseif block to comparing offset.size against the hardcoded
>    sizes in bytes;
> 
> 3) the VMS_VARRAY_* and VMS_VBUFFER_* flags become obsolete. Removed
>    in the next patch;
> 
> 4) memory usage increases +1 byte per vmstate;
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Nice work! Just some minor comments below.

> ---
>  include/migration/vmstate.h | 66 +++++++++++++++++++++++--------------
>  migration/savevm.c          |  4 +--
>  migration/vmstate.c         | 51 ++++++++++++++++++----------
>  3 files changed, 76 insertions(+), 45 deletions(-)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 92a1a9fe98e..2ad3cc01371 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -31,6 +31,7 @@
>  
>  typedef struct VMStateInfo VMStateInfo;
>  typedef struct VMStateField VMStateField;
> +typedef struct VMStateOffset VMStateOffset;
>  
>  /*
>   * VMStateInfo allows customized migration of objects that don't fit in
> @@ -187,6 +188,11 @@ typedef enum {
>      MIG_PRI_MAX,
>  } MigrationPriority;
>  
> +struct VMStateOffset {
> +    uint32_t off;
> +    uint8_t size;
> +};
> +



I think it would be great to add some comments here.

What does the struct describe? size and offset of what where?
And IIUC size 0 has a special meaning?
And neither offset nor size ever come from the migration stream, right?

>  struct VMStateField {
>      const char *name;
>      size_t offset;
> @@ -205,11 +211,11 @@ struct VMStateField {
>       * pointer point to.
>       */
>      size_t size;
> -    size_t size_offset;
> +    VMStateOffset size_offset;
>  
>      size_t start;
>      int num;
> -    size_t num_offset;
> +    VMStateOffset num_offset;
>      const VMStateInfo *info;
>      enum VMStateFlags flags;
>      const VMStateDescription *vmsd;
> @@ -328,6 +334,16 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>      (type_check(t1, typeof_elt_of_field(t2, f))                      \
>       + QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(((t2 *)0)->f)))
>  
> +#define type_check_int64(t)                                             \
> +    (((ptrdiff_t)0 * (ptrdiff_t)(~((t)0))) +                            \
> +     (0 * sizeof(char[(sizeof(t) <= sizeof(uint64_t)) ? 1 : -1])))
> +
> +#define vmstate_field_offset(_state, _field) {                  \
> +    .off = (offsetof(_state, _field) +                          \
> +            type_check_int64(typeof_field(_state, _field))),    \
> +    .size = sizeof(typeof_field(_state, _field)),               \
> +}
> +
>  #define vmstate_offset_value(_state, _field, _type)                  \
>      (offsetof(_state, _field) +                                      \
>       type_check(_type, typeof_field(_state, _field)))
> @@ -454,7 +470,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>  #define VMSTATE_VARRAY_INT32(_field, _state, _field_num, _version, _info, _type) {\
>      .name       = (stringify(_field)),                               \
>      .version_id = (_version),                                        \
> -    .num_offset = vmstate_offset_value(_state, _field_num, int32_t), \
> +    .num_offset = vmstate_field_offset(_state, _field_num),          \
>      .info       = &(_info),                                          \
>      .size       = sizeof(_type),                                     \
>      .flags      = VMS_VARRAY_INT32|VMS_POINTER,                      \
> @@ -464,7 +480,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>  #define VMSTATE_VARRAY_UINT32(_field, _state, _field_num, _version, _info, _type) {\
>      .name       = (stringify(_field)),                               \
>      .version_id = (_version),                                        \
> -    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),\
> +    .num_offset = vmstate_field_offset(_state, _field_num),          \
>      .info       = &(_info),                                          \
>      .size       = sizeof(_type),                                     \
>      .flags      = VMS_VARRAY_UINT32|VMS_POINTER,                     \
> @@ -474,7 +490,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>  #define VMSTATE_VARRAY_INT32_ALLOC(_field, _state, _field_num, _version, _info, _type) {\
>      .name       = (stringify(_field)),                               \
>      .version_id = (_version),                                        \
> -    .num_offset = vmstate_offset_value(_state, _field_num, int32_t), \
> +    .num_offset = vmstate_field_offset(_state, _field_num),          \
>      .info       = &(_info),                                          \
>      .size       = sizeof(_type),                                     \
>      .flags      = VMS_VARRAY_INT32 | VMS_POINTER | VMS_ALLOC,        \
> @@ -484,7 +500,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>  #define VMSTATE_VARRAY_UINT32_ALLOC(_field, _state, _field_num, _version, _info, _type) {\
>      .name       = (stringify(_field)),                               \
>      .version_id = (_version),                                        \
> -    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),\
> +    .num_offset = vmstate_field_offset(_state, _field_num),          \
>      .info       = &(_info),                                          \
>      .size       = sizeof(_type),                                     \
>      .flags      = VMS_VARRAY_UINT32|VMS_POINTER|VMS_ALLOC,           \
> @@ -494,7 +510,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>  #define VMSTATE_VARRAY_UINT16_ALLOC(_field, _state, _field_num, _version, _info, _type) {\
>      .name       = (stringify(_field)),                               \
>      .version_id = (_version),                                        \
> -    .num_offset = vmstate_offset_value(_state, _field_num, uint16_t),\
> +    .num_offset = vmstate_field_offset(_state, _field_num),          \
>      .info       = &(_info),                                          \
>      .size       = sizeof(_type),                                     \
>      .flags      = VMS_VARRAY_UINT16 | VMS_POINTER | VMS_ALLOC,       \
> @@ -504,7 +520,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>  #define VMSTATE_VARRAY_UINT16_UNSAFE(_field, _state, _field_num, _version, _info, _type) {\
>      .name       = (stringify(_field)),                               \
>      .version_id = (_version),                                        \
> -    .num_offset = vmstate_offset_value(_state, _field_num, uint16_t),\
> +    .num_offset = vmstate_field_offset(_state, _field_num),          \
>      .info       = &(_info),                                          \
>      .size       = sizeof(_type),                                     \
>      .flags      = VMS_VARRAY_UINT16,                                 \
> @@ -583,7 +599,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>      _field, _state, _field_num, _version, _vmsd, _type) {            \
>      .name       = (stringify(_field)),                               \
>      .version_id = (_version),                                        \
> -    .num_offset = vmstate_offset_value(_state, _field_num, uint8_t), \
> +    .num_offset = vmstate_field_offset(_state, _field_num),          \
>      .vmsd       = &(_vmsd),                                          \
>      .size       = sizeof(_type),                                     \
>      .flags      = VMS_POINTER | VMS_VARRAY_UINT8 |                   \
> @@ -596,7 +612,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>      _field, _state, _field_num, _version, _vmsd, _type) {             \
>      .name       = (stringify(_field)),                                \
>      .version_id = (_version),                                         \
> -    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t), \
> +    .num_offset = vmstate_field_offset(_state, _field_num),           \
>      .vmsd       = &(_vmsd),                                           \
>      .size       = sizeof(_type),                                      \
>      .flags      = VMS_POINTER | VMS_VARRAY_UINT32 |                   \
> @@ -608,7 +624,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>  #define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _version, _info, _type) { \
>      .name       = (stringify(_field)),                                    \
>      .version_id = (_version),                                             \
> -    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),     \
> +    .num_offset = vmstate_field_offset(_state, _field_num),               \
>      .info       = &(_info),                                               \
>      .flags      = VMS_VARRAY_UINT32 | VMS_ARRAY_OF_POINTER | VMS_POINTER, \
>      .offset     = vmstate_offset_pointer(_state, _field, _type *),          \
> @@ -650,7 +666,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>  
>  #define VMSTATE_STRUCT_VARRAY_UINT8(_field, _state, _field_num, _version, _vmsd, _type) { \
>      .name       = (stringify(_field)),                               \
> -    .num_offset = vmstate_offset_value(_state, _field_num, uint8_t), \
> +    .num_offset = vmstate_field_offset(_state, _field_num),          \
>      .version_id = (_version),                                        \
>      .vmsd       = &(_vmsd),                                          \
>      .size       = sizeof(_type),                                     \
> @@ -674,7 +690,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>  #define VMSTATE_STRUCT_VARRAY_POINTER_INT32(_field, _state, _field_num, _vmsd, _type) { \
>      .name       = (stringify(_field)),                               \
>      .version_id = 0,                                                 \
> -    .num_offset = vmstate_offset_value(_state, _field_num, int32_t), \
> +    .num_offset = vmstate_field_offset(_state, _field_num),          \
>      .size       = sizeof(_type),                                     \
>      .vmsd       = &(_vmsd),                                          \
>      .flags      = VMS_POINTER | VMS_VARRAY_INT32 | VMS_STRUCT,       \
> @@ -684,7 +700,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>  #define VMSTATE_STRUCT_VARRAY_POINTER_UINT32(_field, _state, _field_num, _vmsd, _type) { \
>      .name       = (stringify(_field)),                               \
>      .version_id = 0,                                                 \
> -    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),\
> +    .num_offset = vmstate_field_offset(_state, _field_num),          \
>      .size       = sizeof(_type),                                     \
>      .vmsd       = &(_vmsd),                                          \
>      .flags      = VMS_POINTER | VMS_VARRAY_INT32 | VMS_STRUCT,       \
> @@ -694,7 +710,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>  #define VMSTATE_STRUCT_VARRAY_POINTER_UINT16(_field, _state, _field_num, _vmsd, _type) { \
>      .name       = (stringify(_field)),                               \
>      .version_id = 0,                                                 \
> -    .num_offset = vmstate_offset_value(_state, _field_num, uint16_t),\
> +    .num_offset = vmstate_field_offset(_state, _field_num),          \
>      .size       = sizeof(_type),                                     \
>      .vmsd       = &(_vmsd),                                          \
>      .flags      = VMS_POINTER | VMS_VARRAY_UINT16 | VMS_STRUCT,      \
> @@ -703,7 +719,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>  
>  #define VMSTATE_STRUCT_VARRAY_INT32(_field, _state, _field_num, _version, _vmsd, _type) { \
>      .name       = (stringify(_field)),                               \
> -    .num_offset = vmstate_offset_value(_state, _field_num, int32_t), \
> +    .num_offset = vmstate_field_offset(_state, _field_num, int32_t), \
>      .version_id = (_version),                                        \
>      .vmsd       = &(_vmsd),                                          \
>      .size       = sizeof(_type),                                     \
> @@ -713,7 +729,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>  
>  #define VMSTATE_STRUCT_VARRAY_UINT32(_field, _state, _field_num, _version, _vmsd, _type) { \
>      .name       = (stringify(_field)),                               \
> -    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t), \
> +    .num_offset = vmstate_field_offset(_state, _field_num),          \
>      .version_id = (_version),                                        \
>      .vmsd       = &(_vmsd),                                          \
>      .size       = sizeof(_type),                                     \
> @@ -725,7 +741,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>      .name       = (stringify(_field)),                               \
>      .version_id = (_version),                                        \
>      .vmsd       = &(_vmsd),                                          \
> -    .num_offset = vmstate_offset_value(_state, _field_num, int32_t), \
> +    .num_offset = vmstate_field_offset(_state, _field_num),          \
>      .size       = sizeof(_type),                                     \
>      .flags      = VMS_STRUCT|VMS_VARRAY_INT32|VMS_ALLOC|VMS_POINTER, \
>      .offset     = vmstate_offset_pointer(_state, _field, _type),     \
> @@ -746,7 +762,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>      .name         = (stringify(_field)),                             \
>      .version_id   = (_version),                                      \
>      .field_exists = (_test),                                         \
> -    .size_offset  = vmstate_offset_value(_state, _field_size, uint32_t),\
> +    .size_offset  = vmstate_field_offset(_state, _field_size),       \
>      .size         = (_multiply),                                      \
>      .info         = &vmstate_info_buffer,                            \
>      .flags        = VMS_VBUFFER|VMS_POINTER|VMS_MULTIPLY,            \
> @@ -757,7 +773,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>      .name         = (stringify(_field)),                             \
>      .version_id   = (_version),                                      \
>      .field_exists = (_test),                                         \
> -    .size_offset  = vmstate_offset_value(_state, _field_size, int32_t),\
> +    .size_offset  = vmstate_field_offset(_state, _field_size),       \
>      .info         = &vmstate_info_buffer,                            \
>      .flags        = VMS_VBUFFER|VMS_POINTER,                         \
>      .offset       = offsetof(_state, _field),                        \
> @@ -767,7 +783,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>      .name         = (stringify(_field)),                             \
>      .version_id   = (_version),                                      \
>      .field_exists = (_test),                                         \
> -    .size_offset  = vmstate_offset_value(_state, _field_size, uint32_t),\
> +    .size_offset  = vmstate_field_offset(_state, _field_size),       \
>      .info         = &vmstate_info_buffer,                            \
>      .flags        = VMS_VBUFFER|VMS_POINTER,                         \
>      .offset       = offsetof(_state, _field),                        \
> @@ -777,7 +793,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>      .name         = (stringify(_field)),                             \
>      .version_id   = (_version),                                      \
>      .field_exists = (_test),                                         \
> -    .size_offset  = vmstate_offset_value(_state, _field_size, uint64_t),\
> +    .size_offset  = vmstate_field_offset(_state, _field_size),       \
>      .info         = &vmstate_info_buffer,                            \
>      .flags        = VMS_VBUFFER | VMS_POINTER,                       \
>      .offset       = offsetof(_state, _field),                        \
> @@ -788,7 +804,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>      .name         = (stringify(_field)),                             \
>      .version_id   = (_version),                                      \
>      .field_exists = (_test),                                         \
> -    .size_offset  = vmstate_offset_value(_state, _field_size, uint32_t),\
> +    .size_offset  = vmstate_field_offset(_state, _field_size),       \
>      .info         = &vmstate_info_buffer,                            \
>      .flags        = VMS_VBUFFER|VMS_POINTER|VMS_ALLOC,               \
>      .offset       = offsetof(_state, _field),                        \
> @@ -848,7 +864,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>  #define VMSTATE_UNUSED_VARRAY_UINT32(_state, _test, _version, _field_num, _size) {\
>      .name         = "unused",                                        \
>      .field_exists = (_test),                                         \
> -    .num_offset   = vmstate_offset_value(_state, _field_num, uint32_t),\
> +    .num_offset   = vmstate_field_offset(_state, _field_num),        \
>      .version_id   = (_version),                                      \
>      .size         = (_size),                                         \
>      .info         = &vmstate_info_unused_buffer,                     \
> @@ -862,7 +878,7 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>      .name         = (stringify(_field)),                             \
>      .field_exists = (_test),                                         \
>      .version_id   = (_version),                                      \
> -    .size_offset  = vmstate_offset_value(_state, _field_size, int32_t),\
> +    .size_offset  = vmstate_field_offset(_state, _field_size),       \
>      .info         = &vmstate_info_bitmap,                            \
>      .flags        = VMS_VBUFFER|VMS_POINTER,                         \
>      .offset       = offsetof(_state, _field),                        \
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 34dd06f9f73..a272bcfd0b4 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -873,14 +873,14 @@ static void vmstate_check(const VMStateDescription *vmsd)
>                       * Size must be provided because dest QEMU needs that
>                       * info to know what to allocate
>                       */
> -                    assert(field->size || field->size_offset);
> +                    assert(field->size || field->size_offset.size != 0);

Why is field->size checked by coersing it to bool, but
field->size_offset.size - by comparison to 0?
field->size != 0 for consistency?


>                  } else {
>                      /*
>                       * Otherwise size info isn't useful (because it's
>                       * always the size of host pointer), detect accidental
>                       * setup of sizes in this case.
>                       */
> -                    assert(field->size == 0 && field->size_offset == 0);
> +                    assert(field->size == 0 && field->size_offset.size == 0);
>                  }
>                  /*
>                   * VMS_ARRAY_OF_POINTER must be used only together with one
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 50ebe378452..0a0b9faa20e 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -78,32 +78,45 @@ vmsd_init_ptr_marker_field(VMStateField *fake, const VMStateField *field)
>      };
>  }
>  
> -static int vmstate_n_elems(void *opaque, const VMStateField *field)
> +static uint64_t vmstate_read_from_offset(void *opaque,
> +                                         const VMStateOffset *offset)
>  {
> -    int n_elems = 1;
> +    uint8_t *ptr = (uint8_t *)opaque + offset->off;
> +

The below can easily produce at least UB if offset is
not size aligned.
I *think* offset and size both come from macros that guarantee
this never happens, but maybe better be safe.


> +    switch (offset->size) {
> +    case 1:
> +        return *(uint8_t *)ptr;
> +    case 2:
> +        return *(uint16_t *)ptr;
> +    case 4:
> +        return *(uint32_t *)ptr;
> +    case 8:
> +        return *(uint64_t *)ptr;
> +    }
> +    g_assert_not_reached();
> +}
> +
> +static uint64_t vmstate_n_elems(void *opaque, const VMStateField *field)
> +{
> +    uint64_t n_elems = 1;
>  
>      if (field->flags & VMS_ARRAY) {
>          n_elems = field->num;
> -    } else if (field->flags & VMS_VARRAY_INT32) {
> -        n_elems = *(int32_t *)(opaque + field->num_offset);
> -    } else if (field->flags & VMS_VARRAY_UINT32) {
> -        n_elems = *(uint32_t *)(opaque + field->num_offset);
> -    } else if (field->flags & VMS_VARRAY_UINT16) {
> -        n_elems = *(uint16_t *)(opaque + field->num_offset);
> -    } else if (field->flags & VMS_VARRAY_UINT8) {
> -        n_elems = *(uint8_t *)(opaque + field->num_offset);
> +    } else if (field->flags & (VMS_VARRAY_INT32 | VMS_VARRAY_UINT32
> +                               | VMS_VARRAY_UINT16 | VMS_VARRAY_UINT8)) {
> +        n_elems = vmstate_read_from_offset(opaque, &field->num_offset);
>      }
>  
>      trace_vmstate_n_elems(field->name, n_elems);
>      return n_elems;
>  }
>  
> -static int vmstate_size(void *opaque, const VMStateField *field)
> +static uint64_t vmstate_size(void *opaque, const VMStateField *field)
>  {
> -    int size;
> +    uint64_t size;
>  
>      if (field->flags & VMS_VBUFFER) {
> -        size = *(int32_t *)(opaque + field->size_offset);
> +        size = vmstate_read_from_offset(opaque, &field->size_offset);
>          if (field->flags & VMS_MULTIPLY) {
>              size *= field->size;
>          }
> @@ -124,7 +137,7 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
>                                   void *opaque)
>  {
>      if (field->flags & VMS_POINTER && field->flags & VMS_ALLOC) {
> -        gsize size = vmstate_size(opaque, field);
> +        uint64_t size = vmstate_size(opaque, field);
>          size *= vmstate_n_elems(opaque, field);
>          if (size) {
>              *(void **)ptr = g_malloc(size);
> @@ -335,8 +348,9 @@ bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
>  
>          if (exists) {
>              void *first_elem = opaque + field->offset;
> -            int i, n_elems = vmstate_n_elems(opaque, field);
> -            int size = vmstate_size(opaque, field);
> +            int i;
> +            uint64_t n_elems = vmstate_n_elems(opaque, field);
> +            uint64_t size = vmstate_size(opaque, field);
>  
>              vmstate_handle_alloc(first_elem, field, opaque);
>              if (field->flags & VMS_POINTER) {
> @@ -650,8 +664,9 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>      while (field->name) {
>          if (vmstate_field_exists(vmsd, field, opaque, version_id)) {
>              void *first_elem = opaque + field->offset;
> -            int i, n_elems = vmstate_n_elems(opaque, field);
> -            int size = vmstate_size(opaque, field);
> +            int i;
> +            uint64_t n_elems = vmstate_n_elems(opaque, field);
> +            uint64_t size = vmstate_size(opaque, field);
>              JSONWriter *vmdesc_loop = vmdesc;
>              bool is_prev_null = false;
>              /*
> -- 
> 2.53.0


