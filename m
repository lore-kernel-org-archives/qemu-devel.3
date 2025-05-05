Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EA9C369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 06:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBpLw-0007dq-MA; Mon, 05 May 2025 02:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBpLq-0007Zp-0Z
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:30:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBpLo-0005q1-2l
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746426650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yhmov5sG/ORFAuU3Rz84jzJd1UvHHfeVH5RvRrWsaOw=;
 b=gM5qgQFhbWqwApPq/ySvjq7vN5VixHZuMn8rbxL78xrju/VBC7SWqjHsfiHDcCSIBKZv5c
 cdB04HY2VI2wcUVf4FwHZv22aYfvH7yNkUtzfYjJSspT3cL/CU3B2D7EkIxSCXhZDicLUJ
 SbXzz+ZBV9k/liDvSZpqAqDNS6RDAj8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-sfB9zuj9OX2H5lEve-agOw-1; Mon, 05 May 2025 02:30:48 -0400
X-MC-Unique: sfB9zuj9OX2H5lEve-agOw-1
X-Mimecast-MFC-AGG-ID: sfB9zuj9OX2H5lEve-agOw_1746426646
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912fc9861cso936123f8f.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 23:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746426646; x=1747031446;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yhmov5sG/ORFAuU3Rz84jzJd1UvHHfeVH5RvRrWsaOw=;
 b=jQK7ghkpx6Z9ggQYud1t1IZAHtnYn0bAlQSbAFxSjtmWY/e77BvQBovFUinVLn04KZ
 OM9BBCEe1nOPap1FDr0+uddX1PXcfcNwhA5S6SGV4lk1mgBgux9LZN8xZZiHLMsfreJi
 FEU1A2+vaIa0EF8ekQYrcJQQ4AEd/pzWLtBowvEE9aWVQn/YN6rdXwVhSBSEy1MArEZp
 TWw2Xqp6IZTNEJgigzexi+pFIKM8Padh1nQR+s1C/8mUTq1iIQW+ZZDVDbZ5k3L9vX+A
 BNsf66mW9whYtsPW0sM3ZP1lyDhWf+8ohuOoZbNaTxaPlBpzeDCweFrRvEoBXE3Ry+Rh
 tSIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3JD5n7++FAoTNlNq74dVAHc2Da/1cR+44smrnb6mlY7A1ahXWWGrcTtQWLB40M6YYSHK0YEYtiYqH@nongnu.org
X-Gm-Message-State: AOJu0YyCnkPNiiJhLTs2zu8lDyL0e8y+XQEEWfofKu+AAZQL2YBna57Q
 vGO7V91VXHpXfiGrdRXR1B7c+xcSBzJwqdrFpJ6LBMZke0X3VpIKdP4qXQCZihdbxtIKnFncCYw
 zC/AUW/cpNHdtFLu6Q8/k4BKcu/Iq5qJvgn8YIWXaFweJGG2P6Vgl
X-Gm-Gg: ASbGncu3RZ3s9jIy8juoabkl2Kmeded9iBY1+yJBmVibyhKFIgGranRZK7EdJG8OKos
 gTrUW8nPF2cGZAwCkQolboalbuhrxapHSnH9HYPBYIA+E/pmeWRKJHs+W+NWF7Hvdt102RXrzxz
 R37m1ldyNR9+tGf27z++NcwDi3CX5atRvLdtF5VFbw0HbIO9cUZDv8hYtb7VO0lBCwFH66gEB+k
 YQtVrcUYx81xCgWw9GA4ITDu0HXAFFCfrNduvx0yeiuGmiGo12O0cj1A0WJb1MH0/lVbEPcyllJ
 bq8feG5TfBjeClBCCo92ylIEOPl3xP3P7neVZbSk
X-Received: by 2002:a05:6000:2585:b0:3a0:8acc:1df4 with SMTP id
 ffacd0b85a97d-3a09fd6bc3cmr3879209f8f.7.1746426646112; 
 Sun, 04 May 2025 23:30:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu3Lehe04f1YTTzpbG0RYfm4t5YAUfCPOQ+WBTj5sHgAQvke26n7rc7lNUTqi0tUziBdA/hg==
X-Received: by 2002:a05:6000:2585:b0:3a0:8acc:1df4 with SMTP id
 ffacd0b85a97d-3a09fd6bc3cmr3879174f8f.7.1746426645610; 
 Sun, 04 May 2025 23:30:45 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae796esm9204438f8f.41.2025.05.04.23.30.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 23:30:45 -0700 (PDT)
Message-ID: <41eff78d-db42-4391-a243-ec40e2356627@redhat.com>
Date: Mon, 5 May 2025 08:30:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 2/6] qmp: add QMP command x-query-virtio-status
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 armbru@redhat.com
Cc: mst@redhat.com, qemu_oss@crudebyte.com, kraxel@redhat.com,
 si-wei.liu@oracle.com, joao.m.martins@oracle.com, eblake@redhat.com,
 qemu-block@nongnu.org, david@redhat.com, arei.gonglei@huawei.com,
 marcandre.lureau@redhat.com, lvivier@redhat.com, michael.roth@amd.com,
 groug@kaod.org, dgilbert@redhat.com, eric.auger@redhat.com,
 stefanha@redhat.com, boris.ostrovsky@oracle.com, kwolf@redhat.com,
 mathieu.poirier@linaro.org, raphael.norwitz@nutanix.com,
 pbonzini@redhat.com, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <1660220684-24909-1-git-send-email-jonah.palmer@oracle.com>
 <1660220684-24909-3-git-send-email-jonah.palmer@oracle.com>
 <7de79c4d-57f2-4103-a22e-748cfbe08974@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <7de79c4d-57f2-4103-a22e-748cfbe08974@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 02/05/2025 00.09, Philippe Mathieu-Daudé wrote:
> Hello,
> 
> (patch merged as commit 90c066cd682).
> 
> On 11/8/22 14:24, Jonah Palmer wrote:
>> From: Laurent Vivier <lvivier@redhat.com>
>>
>> This new command shows the status of a VirtIODevice, including
>> its corresponding vhost device's status (if active).
>>
>> Next patch will improve output by decoding feature bits, including
>> vhost device's feature bits (backend, protocol, acked, and features).
>> Also will decode status bits of a VirtIODevice.
>>
>> [Jonah: From patch v12; added a check to @virtio_device_find to ensure
>>   synchronicity between @virtio_list and the devices in the QOM
>>   composition tree.]
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/virtio/virtio-stub.c |   5 +
>>   hw/virtio/virtio.c      | 104 +++++++++++++++++++
>>   qapi/virtio.json        | 222 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 331 insertions(+)
>>
>> diff --git a/hw/virtio/virtio-stub.c b/hw/virtio/virtio-stub.c
>> index 05a81edc92..0b432e8de7 100644
>> --- a/hw/virtio/virtio-stub.c
>> +++ b/hw/virtio/virtio-stub.c
>> @@ -12,3 +12,8 @@ VirtioInfoList *qmp_x_query_virtio(Error **errp)
>>   {
>>       return qmp_virtio_unsupported(errp);
>>   }
>> +
>> +VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>> +{
>> +    return qmp_virtio_unsupported(errp);
>> +}
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index bdfa82e9c0..3e0a484660 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -3939,6 +3939,110 @@ VirtioInfoList *qmp_x_query_virtio(Error **errp)
>>       return list;
>>   }
>> +static VirtIODevice *virtio_device_find(const char *path)
>> +{
>> +    VirtIODevice *vdev;
>> +
>> +    QTAILQ_FOREACH(vdev, &virtio_list, next) {
>> +        DeviceState *dev = DEVICE(vdev);
>> +
>> +        if (strcmp(dev->canonical_path, path) != 0) {
>> +            continue;
>> +        }
>> +
>> +        Error *err = NULL;
>> +        QObject *obj = qmp_qom_get(dev->canonical_path, "realized", &err);
>> +        if (err == NULL) {
>> +            GString *is_realized = qobject_to_json_pretty(obj, true);
>> +            /* virtio device is NOT realized, remove it from list */
>> +            if (!strncmp(is_realized->str, "false", 4)) {
>> +                g_string_free(is_realized, true);
>> +                qobject_unref(obj);
>> +                QTAILQ_REMOVE(&virtio_list, vdev, next);
>> +                return NULL;
>> +            }
>> +            g_string_free(is_realized, true);
>> +        } else {
>> +            /* virtio device doesn't exist in QOM tree */
>> +            QTAILQ_REMOVE(&virtio_list, vdev, next);
>> +            qobject_unref(obj);
>> +            return NULL;
>> +        }
>> +        /* device exists in QOM tree & is realized */
>> +        qobject_unref(obj);
>> +        return vdev;
>> +    }
>> +    return NULL;
>> +}
>> +
>> +VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>> +{
>> +    VirtIODevice *vdev;
>> +    VirtioStatus *status;
>> +
>> +    vdev = virtio_device_find(path);
>> +    if (vdev == NULL) {
>> +        error_setg(errp, "Path %s is not a VirtIODevice", path);
>> +        return NULL;
>> +    }
>> +
>> +    status = g_new0(VirtioStatus, 1);
>> +    status->name = g_strdup(vdev->name);
>> +    status->device_id = vdev->device_id;
>> +    status->vhost_started = vdev->vhost_started;
>> +    status->guest_features = vdev->guest_features;
>> +    status->host_features = vdev->host_features;
>> +    status->backend_features = vdev->backend_features;
>> +
>> +    switch (vdev->device_endian) {
>> +    case VIRTIO_DEVICE_ENDIAN_LITTLE:
>> +        status->device_endian = g_strdup("little");
>> +        break;
>> +    case VIRTIO_DEVICE_ENDIAN_BIG:
>> +        status->device_endian = g_strdup("big");
>> +        break;
>> +    default:
>> +        status->device_endian = g_strdup("unknown");
>> +        break;
>> +    }
>> +
>> +    status->num_vqs = virtio_get_num_queues(vdev);
>> +    status->status = vdev->status;
>> +    status->isr = vdev->isr;
>> +    status->queue_sel = vdev->queue_sel;
>> +    status->vm_running = vdev->vm_running;
>> +    status->broken = vdev->broken;
>> +    status->disabled = vdev->disabled;
>> +    status->use_started = vdev->use_started;
>> +    status->started = vdev->started;
>> +    status->start_on_kick = vdev->start_on_kick;
>> +    status->disable_legacy_check = vdev->disable_legacy_check;
>> +    status->bus_name = g_strdup(vdev->bus_name);
>> +    status->use_guest_notifier_mask = vdev->use_guest_notifier_mask;
>> +    status->has_vhost_dev = vdev->vhost_started;
>> +
>> +    if (vdev->vhost_started) {
>> +        VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
>> +        struct vhost_dev *hdev = vdc->get_vhost(vdev);
>> +
>> +        status->vhost_dev = g_new0(VhostStatus, 1);
>> +        status->vhost_dev->n_mem_sections = hdev->n_mem_sections;
>> +        status->vhost_dev->n_tmp_sections = hdev->n_tmp_sections;
>> +        status->vhost_dev->nvqs = hdev->nvqs;
>> +        status->vhost_dev->vq_index = hdev->vq_index;
>> +        status->vhost_dev->features = hdev->features;
>> +        status->vhost_dev->acked_features = hdev->acked_features;
>> +        status->vhost_dev->backend_features = hdev->backend_features;
>> +        status->vhost_dev->protocol_features = hdev->protocol_features;
>> +        status->vhost_dev->max_queues = hdev->max_queues;
>> +        status->vhost_dev->backend_cap = hdev->backend_cap;
>> +        status->vhost_dev->log_enabled = hdev->log_enabled;
>> +        status->vhost_dev->log_size = hdev->log_size;
>> +    }
>> +
>> +    return status;
>> +}
>> +
>>   static const TypeInfo virtio_device_info = {
>>       .name = TYPE_VIRTIO_DEVICE,
>>       .parent = TYPE_DEVICE,
>> diff --git a/qapi/virtio.json b/qapi/virtio.json
>> index 03896e423f..c86b3bc635 100644
>> --- a/qapi/virtio.json
>> +++ b/qapi/virtio.json
>> @@ -66,3 +66,225 @@
>>   { 'command': 'x-query-virtio',
>>     'returns': [ 'VirtioInfo' ],
>>     'features': [ 'unstable' ] }
> 
> When a structure is only used by an unstable command, is it considered
> unstable too? IOW is it OK to modify it?

IMHO yes. If there is no other user of the struct, why should it considered 
to be stable if the only command that uses it is unstable?

  Thomas


