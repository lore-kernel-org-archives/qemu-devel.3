Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A128CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 08:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqoiA-0004yo-2B; Tue, 26 Aug 2025 04:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqoi7-0004y5-U5
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 04:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqohx-0003XP-Rp
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 04:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756195623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=N346/M2xH5CHPHIm5uVrGAsepZfq/4mg6br+jUGinZw=;
 b=f3F+HzwICLy0/XTN+agdOhG3BcqglV0YOv2XhQtsGTfsmofa6I7j5/gZQKyHZwYJIO9RRi
 37JJ/j3bx4iSxP+09ZiJF0XGLL+wLmR32zMbTsWyciGgOqlcXg7zQv54cP33rqZTGxUa+l
 volRk9rOebX7oLo3NqO/LYHTTQwQJuM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-RPOA5kyLOniD_V29nGTyiw-1; Tue, 26 Aug 2025 04:07:01 -0400
X-MC-Unique: RPOA5kyLOniD_V29nGTyiw-1
X-Mimecast-MFC-AGG-ID: RPOA5kyLOniD_V29nGTyiw_1756195620
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a1b05a59cso37107605e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 01:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756195620; x=1756800420;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N346/M2xH5CHPHIm5uVrGAsepZfq/4mg6br+jUGinZw=;
 b=JIvb3o29NEkwIDk6H/GrV8pq7CgvHbCTNRxuXSQzHBRbL4zr7yC38jdmwA+Y2nhczY
 /TECBpbCla8VDI4UEHkER40nR2Dl6/pHMz7oZcKLa1IvI35irH//JDLRwVTDoysaDP0r
 3jPxgfTS6EqZSuH2Zn5LDuiBDZ9KS3qSpTqof476dy3pVBoc1fHbA3IXjE0aHih4G6dL
 pICrY1oSMOmhIxnQ8nOqRU7Rdy2Z9jyE5HGP7tMkJ5ssmosF7zfZvM+BeVuC1g6PPlmq
 Etxvu9mkHGiyCb9AweKTTK/pDJCU71zxl+jSmww3ngTDnUYodYivQBdz6W/NkRJKSItG
 wgew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl9P8CYN3EJFFEptrb8Z07FtsgStvFj1k4DWiM7IrYsnuLmwoQRDX75lS2sUoIKFxZFR+AbCyDbty7@nongnu.org
X-Gm-Message-State: AOJu0YzE/4aoobs7yYHV2hE8bt1pYVPf5RSHoX0W3CGCi4ZeZToqOaFr
 OBtvZ/5SvyCCBiWHvDroyODjbJ+/HG/GNuTVco21zVxaHvwU8z5Vh2GhHETHkH6Je41BNN0I8Ov
 80ffAkILWmGUlcpZNPb8vpMJdCR+8neJd74oPIUoOKj4QyqQJQkkxXYwdxvKznj2w
X-Gm-Gg: ASbGncvy5zP716okd4u9B3xEEa1O6HdHm+nM9ekiy+4MQLCQTar3BQ7tWEO7KTocJAM
 lnE4WWjh3xOc3zJc/wAUkgpvzS3HspGoD/eYHfcN/bAJSAK7h76MxuGkoI8uXmPft4APwIff4ox
 hnN33aertClWE4bJpBSS4IolsxVZiSxf4k4dDWcifhTOkOi6U2IZ0FK6/ez6DApW9zhoY+8vxLr
 IlcXzgT6J307JyXjvmuhexM7iXvTemeXLWDWQ6wdJufVLTfy5Wn+tzqX0u26nHhcVsk4t9CqdYZ
 kGvQJkYZklblmxg1w4JTJfKIQnwzX8ReJ/YuutEAR2x+AtMzfr6xY4CLt1IuzzW4dsz9M2KEStW
 bXTnR
X-Received: by 2002:a05:600c:1c92:b0:458:bfe1:4a81 with SMTP id
 5b1f17b1804b1-45b6193c94dmr53138545e9.17.1756195619965; 
 Tue, 26 Aug 2025 01:06:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVo0hMlT3clfSQyco23o+4Hg1yX7D0nzF7sKk66rzxR8+hsg70l5TxG4VSeXWfHAKXoPn5rQ==
X-Received: by 2002:a05:600c:1c92:b0:458:bfe1:4a81 with SMTP id
 5b1f17b1804b1-45b6193c94dmr53138245e9.17.1756195619562; 
 Tue, 26 Aug 2025 01:06:59 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-113-247.pools.arcor-ip.net.
 [47.64.113.247]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cad431ea49sm3943063f8f.42.2025.08.26.01.06.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 01:06:59 -0700 (PDT)
Message-ID: <57b7b6c1-1820-4475-b84a-05b37cfbefdf@redhat.com>
Date: Tue, 26 Aug 2025 10:06:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-arm@nongnu.org, 1844144@gmail.com, Jan Richter <jarichte@redhat.com>
References: <20250819143916.4138035-1-gustavo.romero@linaro.org>
 <53b6e23f-5328-42c6-9c58-97ddbf3e5b29@redhat.com>
 <a1105fed-dbd8-4223-b771-180ab12e3f77@linaro.org>
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
In-Reply-To: <a1105fed-dbd8-4223-b771-180ab12e3f77@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 25/08/2025 16.04, Gustavo Romero wrote:
...
>> Anyway, shifting to a different test harness here makes me wonder whether 
>> the whole reverse_debug test should maybe be rather moved to tests/tcg 
>> instead, where we already have the basic support for the stuff from tests/ 
>> guest-debug/ ?
>> The aarch64 would require a different guest payload, of course, in that 
>> case, so not sure whether it's feasible?
> 
> I think reverse_debugging is really a functional test. It requires GDB, yes,
> but also QMP and booting a whole kernel and the feature itself makes me think
> it's a functional test. I wouldn't move it to tcg-check just for the sake of
> no adding a new way to run test in meson.build in functional tests.

Ok, fair point. But thinking about this twice, wouldn't it be nicer to keep 
the current test harness and simply launch the script from the test_* 
methods instead? You could redirect stdout of the script into a log file, so 
that it cannot mess with the TAP output of the test. Or is there something 
that I missed and this cannot work?

  Thomas


