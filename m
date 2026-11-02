Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA93606A331
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 07:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TEwFoFD9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNmXo-0001mI-9C; Mon, 02 Nov 2026 02:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNmXd-0001lV-Ut
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 02:33:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNmXZ-0007e7-Nb
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 02:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793604790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f2QBENPSPtIaADhoClWWoDH2PwREgNQlVqyl6rwGq1Y=;
 b=TEwFoFD9qH9dEVV48eq+pwTzbjk+sF8p1Nb4xnq06DMAYiFdOcnTJjrHB5K3QEnxl4HvFV
 3QES5SwNnB6TtHTg9QYmAWRcYG7lUEV5YTJHxLQcIic7Np0htFu4tniOdEEv/rhMHeZe1D
 yXHzI6dP+vYsBbKtSZcKzi53+09Ho1A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-k1d8tQ5PMmOF3ijaJtQPXA-1; Mon,
 02 Nov 2026 02:33:08 -0500
X-MC-Unique: k1d8tQ5PMmOF3ijaJtQPXA-1
X-Mimecast-MFC-AGG-ID: k1d8tQ5PMmOF3ijaJtQPXA_1793604788
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA8DF1955E75
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 07:33:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B334195604B
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 07:33:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B0EB021E6A04; Mon, 02 Nov 2026 08:33:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: marcandre.lureau@redhat.com
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,
 pbonzini@redhat.com,  berrange@redhat.com
Subject: Re: [PATCH v8 14/56] qom: New object_property_add() etc. parameter
 @qapi_type
In-Reply-To: <179359759593.3177668.4375922821610706196.b4-review@b4>
 (marcandre lureau's message of "Mon, 02 Nov 2026 09:33:15 +0400")
References: <20261101201717.3911097-1-armbru@redhat.com>
 <20261101201717.3911097-15-armbru@redhat.com>
 <179359759593.3177668.4375922821610706196.b4-review@b4>
Date: Mon, 02 Nov 2026 08:33:04 +0100
Message-ID: <8733tjvgb3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

marcandre.lureau@redhat.com writes:

>> This permits setting ObjectProperty's optional @qapi_type.  For now,
>> all callers pass null.  Callers updated with this Coccinelle script:
>> 
>> @@
>> identifier fun = {
>>     object_property_try_add, object_property_add, object_class_property_add
>> };
>> expression obj, name, type;
>> @@
>> -    fun(obj, name, type,
>> +    fun(obj, name, type, NULL,
>>      ...)
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Message-ID: <20261101201717.3911097-15-armbru@redhat.com>

[...]

>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index e9b380462ded..84b273e53545 100644
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -1163,6 +1163,7 @@ void object_unref(void *obj);
>>   *   defined.  Sub namespaces are constructed by using a prefix and then
>>   *   to angle brackets.  For instance, the type 'virtio-net-pci' in the
>>   *   'link' namespace would be 'link<virtio-net-pci>'.
>> + * @qapi_type: QAPI type info descriptor
>>   * @get: The getter to be called to read a property.  If this is NULL, then
>>   *   the property cannot be read.
>>   * @set: the setter to be called to write a property.  If this is NULL,
>> @@ -1188,6 +1189,7 @@ void object_unref(void *obj);
>>   */
>>  ObjectProperty *object_property_try_add(Object *obj, const char *name,
>>                                          const char *type,
>> +                                        QAPITypeInfo *qapi_type,
>
> should be const QAPITypeInfo *

Yes.  Not caught by the compiler, because there are just three calls,
and I messed up the two of them that should pass something, as you noted
below.  Not caught by my testing probably because pretty much nothing
uses them.

>>                                          ObjectPropertyAccessor *get,
>>                                          ObjectPropertyAccessor *set,
>>                                          ObjectPropertyRelease *release,
>> @@ -1203,6 +1205,7 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
>>   *   defined.  Sub namespaces are constructed by using a prefix and then
>>   *   to angle brackets.  For instance, the type 'virtio-net-pci' in the
>>   *   'link' namespace would be 'link<virtio-net-pci>'.
>> + * @qapi_type: QAPI type info descriptor
>>   * @get: The getter to be called to read a property.  If this is NULL, then
>>   *   the property cannot be read.
>>   * @set: the setter to be called to write a property.  If this is NULL,
>> @@ -1220,6 +1223,7 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
>>   */
>>  ObjectProperty *object_property_add(Object *obj, const char *name,
>>                                      const char *type,
>> +                                    const QAPITypeInfo *qapi_type,
>>                                      ObjectPropertyAccessor *get,
>>                                      ObjectPropertyAccessor *set,
>>                                      ObjectPropertyRelease *release,
>> @@ -1237,6 +1241,7 @@ void object_property_del(Object *obj, const char *name);
>>  
>>  ObjectProperty *object_class_property_add(ObjectClass *klass, const char *name,
>>                                            const char *type,
>> +                                          const QAPITypeInfo *qapi_type,
>>                                            ObjectPropertyAccessor *get,
>>                                            ObjectPropertyAccessor *set,
>>                                            ObjectPropertyRelease *release,
>> diff --git a/iothread.c b/iothread.c
>> index 76eea6df3861..7084d336a400 100644
>> --- a/iothread.c
>> +++ b/iothread.c
>> @@ -315,19 +315,19 @@ static void iothread_class_init(ObjectClass *klass, const void *class_data)
>>      bc->init = iothread_init;
>>      bc->update_params = iothread_set_aio_context_params;
>>  
>> -    object_class_property_add(klass, "poll-max-ns", "int64",
>> +    object_class_property_add(klass, "poll-max-ns", "int64", NULL,
>>                                iothread_get_poll_param,
>>                                iothread_set_poll_param,
>>                                NULL, &poll_max_ns_info);
>> -    object_class_property_add(klass, "poll-grow", "int64",
>> +    object_class_property_add(klass, "poll-grow", "int64", NULL,
>>                                iothread_get_poll_param,
>>                                iothread_set_poll_param,
>>                                NULL, &poll_grow_info);
>> -    object_class_property_add(klass, "poll-shrink", "int64",
>> +    object_class_property_add(klass, "poll-shrink", "int64", NULL,
>>                                iothread_get_poll_param,
>>                                iothread_set_poll_param,
>>                                NULL, &poll_shrink_info);
>> -    object_class_property_add(klass, "poll-weight", "int64",
>> +    object_class_property_add(klass, "poll-weight", "int64", NULL,
>>                                iothread_get_poll_param,
>>                                iothread_set_poll_param,
>>                                NULL, &poll_weight_info);
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index 5986fb1e8800..7d4a2db522ad 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -1373,15 +1373,15 @@ static void colo_compare_init(Object *obj)
>>      object_property_add_str(obj, "notify_dev",
>>                              compare_get_notify_dev, compare_set_notify_dev);
>>  
>> -    object_property_add(obj, "compare_timeout", "uint64",
>> +    object_property_add(obj, "compare_timeout", "uint64", NULL,
>>                          compare_get_timeout,
>>                          compare_set_timeout, NULL, NULL);
>>  
>> -    object_property_add(obj, "expired_scan_cycle", "uint32",
>> +    object_property_add(obj, "expired_scan_cycle", "uint32", NULL,
>>                          compare_get_expired_scan_cycle,
>>                          compare_set_expired_scan_cycle, NULL, NULL);
>>  
>> -    object_property_add(obj, "max_queue_size", "uint32",
>> +    object_property_add(obj, "max_queue_size", "uint32", NULL,
>>                          get_max_queue_size,
>>                          set_max_queue_size, NULL, NULL);
>>  
>> diff --git a/net/dump.c b/net/dump.c
>> index 0c39f09892c2..558115b9c9e3 100644
>> --- a/net/dump.c
>> +++ b/net/dump.c
>> @@ -238,7 +238,8 @@ static void filter_dump_class_init(ObjectClass *oc, const void *data)
>>  {
>>      NetFilterClass *nfc = NETFILTER_CLASS(oc);
>>  
>> -    object_class_property_add(oc, "maxlen", "uint32", filter_dump_get_maxlen,
>> +    object_class_property_add(oc, "maxlen", "uint32", NULL,
>> +                              filter_dump_get_maxlen,
>>                                filter_dump_set_maxlen, NULL, NULL);
>>      object_class_property_add_str(oc, "file", file_dump_get_filename,
>>                                    file_dump_set_filename);
>> diff --git a/net/filter-buffer.c b/net/filter-buffer.c
>> index 427da24097f2..f56b2cfaf0b1 100644
>> --- a/net/filter-buffer.c
>> +++ b/net/filter-buffer.c
>> @@ -182,7 +182,7 @@ static void filter_buffer_class_init(ObjectClass *oc, const void *data)
>>  {
>>      NetFilterClass *nfc = NETFILTER_CLASS(oc);
>>  
>> -    object_class_property_add(oc, "interval", "uint32",
>> +    object_class_property_add(oc, "interval", "uint32", NULL,
>>                                filter_buffer_get_interval,
>>                                filter_buffer_set_interval, NULL, NULL);
>>  
>> diff --git a/qom/object.c b/qom/object.c
>> index c34b47312f29..0fbd4a7edfbe 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -1340,6 +1340,7 @@ void object_unref(void *objptr)
>>  
>>  ObjectProperty *
>>  object_property_try_add(Object *obj, const char *name, const char *type,
>> +                        QAPITypeInfo *qapi_type,
>>                          ObjectPropertyAccessor *get,
>>                          ObjectPropertyAccessor *set,
>>                          ObjectPropertyRelease *release,
>> @@ -1357,8 +1358,8 @@ object_property_try_add(Object *obj, const char *name, const char *type,
>>          for (i = 0; i < INT16_MAX; ++i) {
>>              char *full_name = g_strdup_printf("%s[%d]", name_no_array, i);
>>  
>> -            ret = object_property_try_add(obj, full_name, type, get, set,
>> -                                          release, opaque, NULL);
>> +            ret = object_property_try_add(obj, full_name, type, NULL,
>
> Propagate @qapi_type to the generated name[i] properties.

Yes, this is #1, and ...

>> +                                          get, set, release, opaque, NULL);
>>              g_free(full_name);
>>              if (ret) {
>>                  break;
>> @@ -1379,6 +1380,7 @@ object_property_try_add(Object *obj, const char *name, const char *type,
>>  
>>      prop->name = g_strdup(name);
>>      prop->type = g_strdup(type);
>> +    prop->qapi_type = qapi_type;
>>  
>>      prop->get = get;
>>      prop->set = set;
>> @@ -1393,12 +1395,13 @@ object_property_try_add(Object *obj, const char *name, const char *type,
>>  
>>  ObjectProperty *
>>  object_property_add(Object *obj, const char *name, const char *type,
>> +                    const QAPITypeInfo *qapi_type,
>>                      ObjectPropertyAccessor *get,
>>                      ObjectPropertyAccessor *set,
>>                      ObjectPropertyRelease *release,
>>                      void *opaque)
>>  {
>> -    return object_property_try_add(obj, name, type, get, set, release,
>> +    return object_property_try_add(obj, name, type, NULL, get, set, release,
>
> This should pass @qapi_type also

... this is #2.

Thanks!


